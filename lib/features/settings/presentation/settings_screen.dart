import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../library/data/remote/radarr_service.dart';
import '../../library/data/remote/sonarr_service.dart';
import '../data/settings_repository.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port21/features/settings/domain/settings.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  late TextEditingController _radarrUrlCtrl;
  late TextEditingController _radarrKeyCtrl;
  late TextEditingController _sonarrUrlCtrl;
  late TextEditingController _sonarrKeyCtrl;
  late TextEditingController _tmdbKeyCtrl;
  
  late TextEditingController _ftpHostCtrl;
  late TextEditingController _ftpPortCtrl;
  late TextEditingController _ftpUserCtrl;
  late TextEditingController _ftpPassCtrl;
  late TextEditingController _remotePrefixCtrl;
  late TextEditingController _ftpPrefixCtrl;
  String _streamProtocol = 'ftp';


  @override
  void initState() {
    super.initState();
    final currentSettings = ref.read(settingsRepositoryProvider).getSettings();
    
    _radarrUrlCtrl = TextEditingController(text: currentSettings.radarrUrl);
    _radarrKeyCtrl = TextEditingController(text: currentSettings.radarrApiKey);
    _sonarrUrlCtrl = TextEditingController(text: currentSettings.sonarrUrl);
    _sonarrUrlCtrl = TextEditingController(text: currentSettings.sonarrUrl);
    _sonarrKeyCtrl = TextEditingController(text: currentSettings.sonarrApiKey);
    _tmdbKeyCtrl = TextEditingController(text: currentSettings.tmdbApiKey);
    
    _ftpHostCtrl = TextEditingController(text: currentSettings.ftpHost);
    _ftpPortCtrl = TextEditingController(text: currentSettings.ftpPort.toString());
    _ftpUserCtrl = TextEditingController(text: currentSettings.ftpUser);
    _ftpPassCtrl = TextEditingController(text: currentSettings.ftpPassword);
    
    _remotePrefixCtrl = TextEditingController(text: currentSettings.remotePathPrefix);
    _ftpPrefixCtrl = TextEditingController(text: currentSettings.ftpPathPrefix);
    _streamProtocol = currentSettings.streamProtocol.isEmpty ? 'ftp' : currentSettings.streamProtocol;
  }

  @override
  void dispose() {
    _radarrUrlCtrl.dispose();
    _radarrKeyCtrl.dispose();
    _sonarrUrlCtrl.dispose();
    _sonarrKeyCtrl.dispose();
    _tmdbKeyCtrl.dispose();
    _ftpHostCtrl.dispose();
    _ftpPortCtrl.dispose();
    _ftpUserCtrl.dispose();
    _ftpPassCtrl.dispose();
    _remotePrefixCtrl.dispose();
    _ftpPrefixCtrl.dispose();
    super.dispose();
  }


  
  Future<void> _testConnections() async {
     if (!_formKey.currentState!.validate()) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Please fill all required fields first.')),
       );
       return;
     }
     
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Testing connections...')),
     );
     
     // Create temporary dio instance
     final dio = Dio();
     dio.options.connectTimeout = const Duration(seconds: 5);
     
     // Test Radarr
     bool radarrOk = false;
     try {
       final radarrService = RadarrService(
          dio, 
          baseUrl: _radarrUrlCtrl.text.trim(), 
          apiKey: _radarrKeyCtrl.text.trim()
       );
       radarrOk = await radarrService.testConnection();
     } catch (_) {}

     // Test Sonarr
     bool sonarrOk = false;
     try {
       final sonarrService = SonarrService(
          dio, 
          baseUrl: _sonarrUrlCtrl.text.trim(), 
          apiKey: _sonarrKeyCtrl.text.trim()
       );
       sonarrOk = await sonarrService.testConnection();
     } catch (_) {}
     
     if (mounted) {
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: const Text("Connection Results"),
           content: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               ListTile(
                 leading: Icon(radarrOk ? Icons.check_circle : Icons.error, color: radarrOk ? Colors.green : Colors.red),
                 title: const Text("Radarr"),
                 subtitle: Text(radarrOk ? "Connected" : "Failed"),
               ),
               ListTile(
                 leading: Icon(sonarrOk ? Icons.check_circle : Icons.error, color: sonarrOk ? Colors.green : Colors.red),
                 title: const Text("Sonarr"),
                 subtitle: Text(sonarrOk ? "Connected" : "Failed"),
               ),
             ],
           ),
           actions: [
             TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
           ],
         ),
       );
     }
  }

  Future<void> _scanQrCode() async {
    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Scan Config QR")),
            body: MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final code = barcodes.first.rawValue;
                  if (code != null) {
                    Navigator.pop(context, code);
                  }
                }
              },
            ),
          ),
        ),
      );

      if (result != null && result is String) {
        _applyConfigFromJson(result);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning: $e')),
      );
    }
  }

  Future<void> _pickConfigFile() async {
     try {
       // Pick file
       FilePickerResult? result = await FilePicker.platform.pickFiles(
         type: FileType.custom,
         allowedExtensions: ['json', 'txt'],
       );

       if (result != null && result.files.single.path != null) {
          final file = File(result.files.single.path!);
          final content = await file.readAsString();
          _applyConfigFromJson(content);
       }
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Error picking file: $e')),
       );
     }
  }

  void _applyConfigFromJson(String jsonStr) {
    try {
      final Map<String, dynamic> json = jsonDecode(jsonStr);
      
      setState(() {
        if (json['radarrUrl'] != null) _radarrUrlCtrl.text = json['radarrUrl'];
        if (json['radarrApiKey'] != null) _radarrKeyCtrl.text = json['radarrApiKey'];
        if (json['sonarrUrl'] != null) _sonarrUrlCtrl.text = json['sonarrUrl'];
        if (json['sonarrApiKey'] != null) _sonarrKeyCtrl.text = json['sonarrApiKey'];
        
        if (json['ftpHost'] != null) _ftpHostCtrl.text = json['ftpHost'];
        if (json['ftpPort'] != null) _ftpPortCtrl.text = json['ftpPort'].toString();
        if (json['ftpUser'] != null) _ftpUserCtrl.text = json['ftpUser'];
        if (json['ftpPassword'] != null) _ftpPassCtrl.text = json['ftpPassword'];
        
        if (json['remotePathPrefix'] != null) _remotePrefixCtrl.text = json['remotePathPrefix'];
        if (json['ftpPathPrefix'] != null) _ftpPrefixCtrl.text = json['ftpPathPrefix'];
        if (json['streamProtocol'] != null) {
           _streamProtocol = json['streamProtocol'];
        } else if (json['ftpIsSecure'] == true) {
           _streamProtocol = 'ftps';
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuration Applied! Click Save to persist.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid QR Configuration Format')),
      );
    }
  }

  void _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      final repo = ref.read(settingsRepositoryProvider);
      
      final newSettings = Settings(
        radarrUrl: _radarrUrlCtrl.text.trim(),
        radarrApiKey: _radarrKeyCtrl.text.trim(),
        sonarrUrl: _sonarrUrlCtrl.text.trim(),
        sonarrApiKey: _sonarrKeyCtrl.text.trim(),
        ftpHost: _ftpHostCtrl.text.trim(),
        ftpPort: int.tryParse(_ftpPortCtrl.text.trim()) ?? 21,
        ftpUser: _ftpUserCtrl.text.trim(),
        ftpPassword: _ftpPassCtrl.text.trim(),
        remotePathPrefix: _remotePrefixCtrl.text.trim(),
        ftpPathPrefix: _ftpPrefixCtrl.text.trim(),
        streamProtocol: _streamProtocol,
        tmdbApiKey: _tmdbKeyCtrl.text.trim(),
      );

      await repo.saveSettings(newSettings);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings Saved')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: _scanQrCode,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
             // Scan Config Button (Redundant)
             Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                         onPressed: _scanQrCode,
                         icon: const Icon(Icons.qr_code_scanner),
                         label: const Text("SCAN QR"),
                         style: FilledButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                         ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                         onPressed: _pickConfigFile,
                         icon: const Icon(Icons.upload_file),
                         label: const Text("UPLOAD JSON"),
                         style: FilledButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                         ),
                      ),
                    ),
                  ],
                ),
             ),

             // Test Connection Button
             Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: OutlinedButton.icon(
                   onPressed: _testConnections,
                   icon: const Icon(Icons.wifi_find),
                   label: const Text("TEST CONNECTIONS"),
                   style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blueAccent),
                      foregroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                   ),
                ),
             ),
             
            _buildSectionHeader("Radarr (Movies)"),
            _buildTextField("Base URL", _radarrUrlCtrl, hint: "http://192.168.1.5:7878/api/v3"),
            _buildTextField("API Key", _radarrKeyCtrl),
            
            const SizedBox(height: 24),
            _buildSectionHeader("Sonarr (Series)"),
            _buildTextField("Base URL", _sonarrUrlCtrl, hint: "http://192.168.1.5:8989/api/v3"),
            _buildTextField("API Key", _sonarrKeyCtrl),

            const SizedBox(height: 24),
            _buildSectionHeader("TMDB (Discovery & Images)"),
            _buildTextField("API Key (v3)", _tmdbKeyCtrl),
            
            const SizedBox(height: 24),
            _buildSectionHeader("FTP Configuration"),
            Row(
              children: [
                Expanded(flex: 3, child: _buildTextField("Host", _ftpHostCtrl, hint: "192.168.1.5")),
                const SizedBox(width: 8),
                Expanded(flex: 1, child: _buildTextField("Port", _ftpPortCtrl, isNumber: true)),
              ],
            ),
            _buildTextField("Username", _ftpUserCtrl),
            _buildTextField("Password", _ftpPassCtrl, isObscure: true),
            

            
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _streamProtocol,
              dropdownColor: const Color(0xFF282C34),
              decoration: const InputDecoration(
                labelText: "Protocol",
                labelStyle: TextStyle(color: Colors.tealAccent),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.tealAccent)),
              ),
              style: const TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(value: 'ftp', child: Text("FTP (Plain)")),
                DropdownMenuItem(value: 'ftps', child: Text("FTPS (Explicit TLS)")),
                DropdownMenuItem(value: 'sftp', child: Text("SFTP (SSH)")),
                DropdownMenuItem(value: 'http', child: Text("HTTP")),
                DropdownMenuItem(value: 'https', child: Text("HTTPS")),
              ], 
              onChanged: (val) => setState(() => _streamProtocol = val ?? 'ftp'),
            ),

            const SizedBox(height: 24),
            _buildSectionHeader("Path Mapping"),
            const Text(
              "Maps local file paths from Radarr (e.g. /mnt/media) to FTP paths (e.g. /media).",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 8),
            _buildTextField("Remote Prefix (Remove)", _remotePrefixCtrl, hint: "/mnt/media"),
            _buildTextField("FTP Prefix (Add)", _ftpPrefixCtrl, hint: "/media"),
            
            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00E5FF),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    TextEditingController controller, {
    String? hint,
    bool isObscure = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        validator: (value) {
          if (!isNumber && (value == null || value.isEmpty)) {
            // Optional fields logic? Let's make URLs required.
            if (label.contains("URL") || label.contains("Host")) {
               return 'Required';
            }
          }
          return null;
        },
      ),
    );
  }
}
