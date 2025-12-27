import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../player/application/video_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../library/presentation/widgets/movie_detail_bottom_sheet.dart';
import '../../library/presentation/widgets/series_detail_bottom_sheet.dart';
import '../application/home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Building HomeScreen");
    return Scaffold(
      backgroundColor: Colors.black, // Deep Matte Black
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/images/logo.png', height: 32, errorBuilder: (_,__,___) => const Text("PORT 21", style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.w900))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             _HeroSection(),
             const SizedBox(height: 24),
             _ContinueWatchingRail(),
             const SizedBox(height: 24),
             _ContentRail(title: "Check 'Em Out", provider: recentlyAddedRailsProvider),
             const SizedBox(height: 16),
             _ContentRail(title: "Movies", provider: allMoviesRailProvider),
             const SizedBox(height: 16),
             _ContentRail(title: "TV Series", provider: allSeriesRailProvider),
             const SizedBox(height: 80), // Padding for nav bar
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredContentProvider);

    return featuredAsync.when(
      data: (featured) {
         if (featured == null) return const SizedBox(height: 400, child: Center(child: Text("Library Empty")));
         
         // Use poster if backdrop missing (common in local library)
         final imageUrl = featured.backdropUrl ?? featured.posterUrl;
         
         return SizedBox(
           height: 500,
           child: Stack(
             fit: StackFit.expand,
             children: [
               // Background Image
               if (imageUrl != null)
                 CachedNetworkImage(
                   imageUrl: "https://image.tmdb.org/t/p/original$imageUrl",
                   fit: BoxFit.cover,
                   placeholder: (_,__) => Container(color: Colors.grey[900]),
                   errorWidget: (_,__,___) => Container(color: Colors.grey[900]),
                 ),
                 
               // Gradient Overlay
               Container(
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                     colors: [
                       Colors.black.withOpacity(0.2), // Top transparency
                       Colors.transparent,
                       Colors.black.withOpacity(0.8), // Fade to black
                       Colors.black,
                     ],
                     stops: const [0.0, 0.4, 0.8, 1.0],
                   ),
                 ),
               ),
               
               // Content Info
               Positioned(
                 bottom: 24,
                 left: 24,
                 right: 24,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                      Text(
                        featured.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          shadows: [BoxShadow(color: Colors.black, blurRadius: 10)],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(featured.overview ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70)),
                      // const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           FilledButton.icon(
                             style: FilledButton.styleFrom(
                               backgroundColor: Colors.white, 
                               foregroundColor: Colors.black,
                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                             ),
                             onPressed: () {
                                // Play Action
                                VideoLauncher.launch(
                                  context,
                                  featured.isMovie ? (featured.originalItem as dynamic).path : '',
                                  featured.contentId,
                                );
                             },
                             icon: const Icon(Icons.play_arrow),
                             label: const Text("PLAY"),
                           ),
                           const SizedBox(width: 16),
                           OutlinedButton.icon(
                             style: OutlinedButton.styleFrom(
                               foregroundColor: Colors.white,
                               side: const BorderSide(color: Colors.white),
                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                             ),
                             onPressed: () {
                                // Info Action
                                if (featured.isMovie) {
                                   showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => MovieDetailBottomSheet(movie: featured.originalItem));
                                } else {
                                   showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => SeriesDetailBottomSheet(series: featured.originalItem));
                                }
                             },
                             icon: const Icon(Icons.info_outline),
                             label: const Text("INFO"),
                           ),
                        ],
                      )
                   ],
                 ),
               ),
             ],
           ),
         );
      },
      loading: () => const SizedBox(height: 500, child: Center(child: CircularProgressIndicator())),
      error: (_,__) => const SizedBox.shrink(),
    );
  }
}

class _ContinueWatchingRail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(continueWatchingRailProvider);
    
    return listAsync.when(
       data: (items) {
          if (items.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16),
                 child: Text("Continue Watching", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
               ),
               const SizedBox(height: 12),
               SizedBox(
                 height: 140,
                 child: ListView.separated(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                   scrollDirection: Axis.horizontal,
                   itemCount: items.length,
                   separatorBuilder: (_,__) => const SizedBox(width: 12),
                   itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {
                           VideoLauncher.launch(
                             context,
                             (item.originalItem as dynamic).path,
                             item.contentId,
                           );
                        },
                        child: Container(
                          width: 220,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(8),
                            image: item.backdropUrl != null ? DecorationImage(
                               image: NetworkImage("https://image.tmdb.org/t/p/w500${item.backdropUrl}"),
                               fit: BoxFit.cover,
                               colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                            ) : null,
                          ),
                          child: Stack(
                            children: [
                               Positioned(
                                 bottom: 0, left: 0, right: 0,
                                 child: Column(
                                   children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ),
                                      LinearProgressIndicator(value: item.progress, color: Colors.tealAccent, backgroundColor: Colors.white12, minHeight: 2),
                                   ],
                                 ),
                               ),
                               const Positioned.fill(child: Icon(Icons.play_circle_outline, color: Colors.white70, size: 48)),
                            ],
                          ),
                        ),
                      );
                   },
                 ),
               ),
            ],
          );
       },
       loading: () => const SizedBox.shrink(),
       error: (_,__) => const SizedBox.shrink(),
    );
  }
}

class _ContentRail extends ConsumerWidget {
  final String title;
  final AutoDisposeFutureProvider<List<HomeContent>> provider;

  const _ContentRail({required this.title, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(provider);

    return listAsync.when(
      data: (items) {
         if (items.isEmpty) return const SizedBox.shrink();
         return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
               ),
               const SizedBox(height: 12),
               SizedBox(
                 height: 200,
                 child: ListView.separated(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                   scrollDirection: Axis.horizontal,
                   itemCount: items.length,
                   separatorBuilder: (_,__) => const SizedBox(width: 12),
                   itemBuilder: (context, index) {
                      final item = items[index];
                      // Use PosterHelper logic ideally, but simplified here for now:
                      final posterUrl = item.posterUrl;
                      
                      return GestureDetector(
                        onTap: () {
                          if (item.isMovie) {
                             showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => MovieDetailBottomSheet(movie: item.originalItem));
                          } else {
                             showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => SeriesDetailBottomSheet(series: item.originalItem));
                          }
                        },
                        child: SizedBox(
                          width: 130, // Poster width
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: posterUrl != null ? CachedNetworkImage(
                                    imageUrl: posterUrl!.startsWith('http') ? posterUrl! : "https://image.tmdb.org/t/p/w500$posterUrl",
                                    fit: BoxFit.cover,
                                    errorWidget: (_,__,___) => Container(color: Colors.grey[800], child: const Icon(Icons.movie)),
                                  ) : Container(color: Colors.grey[800], child: const Icon(Icons.movie)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                   },
                 ),
               ),
            ],
         );
      },
      loading: () => const SizedBox.shrink(),
      error: (_,__) => const SizedBox.shrink(),
    );
  }
}
