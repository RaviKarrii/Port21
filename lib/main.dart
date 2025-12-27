import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:io';

import 'core/presentation/app_router.dart';
import 'core/presentation/splash_screen.dart';
import 'features/library/application/library_providers.dart';
import 'features/library/data/local/movie_entity.dart';
import 'features/library/data/local/series_entity.dart';
import 'features/library/data/local/series_entity.dart';
import 'features/settings/data/settings_repository.dart';
import 'features/player/domain/playback_position.dart'; // Added



import 'package:media_kit/media_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  
  // Enforce Portrait Mode globally
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const AppStartupWidget());
}

class AppStartupWidget extends StatefulWidget {
  const AppStartupWidget({super.key});

  @override
  State<AppStartupWidget> createState() => _AppStartupWidgetState();
}

class _AppStartupWidgetState extends State<AppStartupWidget> {
  // We hold dependencies here to inject into ProviderScope
  SharedPreferences? _prefs;
  Isar? _isar;
  bool _initialized = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      // 1. Init SharedPrefs
      _prefs = await SharedPreferences.getInstance();

      // 1.1 Init Downloader
      // Note: flutter_downloader might need to run on native main thread, 
      // but ensureInitialized was called.
      // We wrap in try-catch in case of platform issues.
      try {
         await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
      } catch (e) {
        debugPrint("FlutterDownloader init failed: $e");
        // Don't crash app for this, but downloads won't work.
      }
      
      // 2. Init Isar
      final dir = await getApplicationDocumentsDirectory();
      try {
        _isar = await Isar.open(
          [MovieEntitySchema, SeriesEntitySchema, PlaybackPositionSchema],
          directory: dir.path,
        );
      } catch (e) {
        // Fix for "Collection id is invalid" or Schema mismatch
        debugPrint("Isar init failed ($e). Clearing DB and retrying...");
        final isarName = 'default'; 
        // Force delete the old DB 
        await Isar.open(
          [MovieEntitySchema, SeriesEntitySchema, PlaybackPositionSchema],
          directory: dir.path,
          name: 'temp_cleanup',
        ).then((isar) {
             isar.close(deleteFromDisk: true);
        }).catchError((_) {
             // If normal open fails, try manual file deletion (brute force)
             try {
                final dbFile = File('${dir.path}/$isarName.isar');
                if (dbFile.existsSync()) dbFile.deleteSync();
                final lockFile = File('${dir.path}/$isarName.isar.lock');
                if (lockFile.existsSync()) lockFile.deleteSync();
             } catch (e2) {
                debugPrint("Manual deletion failed: $e2");
             }
        });

        // Retry open
        _isar = await Isar.open(
          [MovieEntitySchema, SeriesEntitySchema, PlaybackPositionSchema],
          directory: dir.path,
        );
      }

      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e, stack) {
      debugPrint("Startup Error: $e\n$stack");
      if (mounted) {
        setState(() {
          _error = e;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Show Splash
    if (!_initialized && _error == null) {
      return const SplashScreen();
    }

    // 2. Show Error
    if (_error != null) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.error_outline, color: Colors.red, size: 48),
                   const SizedBox(height: 16),
                   const Text(
                     "Startup Failed", 
                     style: TextStyle(color: Colors.white, fontSize: 20),
                   ),
                   const SizedBox(height: 8),
                   Text(
                     _error.toString(), 
                     style: const TextStyle(color: Colors.white70),
                     textAlign: TextAlign.center,
                   ),
                   const SizedBox(height: 24),
                   ElevatedButton(
                     onPressed: () {
                       setState(() {
                         _error = null;
                         _initialized = false;
                       });
                       _initApp();
                     }, 
                     child: const Text("Retry")
                   )
                ],
              ),
            ),
          ),
        ),
      );
    }

    // 3. Launch App
    return ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWith((ref) => SettingsRepository(_prefs!)),
        isarProvider.overrideWith((ref) => _isar!),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Industrial Slate Theme Definition
    const slateColor = Color(0xFF282C34);
    const matteBlack = Color(0xFF0A0A0A);
    const starkWhite = Color(0xFFEEEEEE);
    const industrialGrey = Color(0xFF495057);

    return MaterialApp.router(
      title: 'Port 21',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: matteBlack,
        
        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: slateColor,
          brightness: Brightness.dark,
          primary: starkWhite,
          onPrimary: Colors.black,
          secondary: slateColor,
          onSecondary: starkWhite,
          surface: Colors.black, // Starker surface
          onSurface: starkWhite,
          background: matteBlack,
        ),
        
        // Typography: Industrial/Swiss Style
        textTheme: GoogleFonts.robotoCondensedTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: starkWhite,
          displayColor: starkWhite,
        ).copyWith(
          headlineSmall: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: starkWhite,
          ),
          titleLarge: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.25,
            color: starkWhite,
          ),
          labelLarge: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0, 
            // toUpperCase is not a valid property here
          ),
        ),

        // AppBar: Flat, bordered
        appBarTheme: AppBarTheme(
          backgroundColor: matteBlack,
          foregroundColor: starkWhite,
          elevation: 0,
          centerTitle: false, // Left aligned industrial look
          titleTextStyle: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: starkWhite,
          ),
          shape: Border(bottom: BorderSide(color: industrialGrey, width: 1)),
        ),

        // Buttons: Sharp corners, flat
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: starkWhite,
            foregroundColor: Colors.black,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 0,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        
        // Inputs: Industrial boxes
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF151515),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: industrialGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: industrialGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: starkWhite, width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelStyle: TextStyle(color: starkWhite),
        ),

        // Cards/Dialogs: Sharp
        // Removed CardTheme temporarily to resolve type mismatch
        
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFF151515),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      routerConfig: router,
    );
  }
}
