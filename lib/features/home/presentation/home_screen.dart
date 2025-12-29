import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../player/application/video_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../library/presentation/widgets/movie_detail_bottom_sheet.dart';
import '../../library/presentation/widgets/series_detail_bottom_sheet.dart';
import '../application/home_providers.dart';
import '../../library/application/library_providers.dart'; // For tmdbServiceProvider
import '../../library/domain/movie.dart';
import '../../library/domain/series.dart';

class HomeScreen extends ConsumerWidget {
  final bool isMovie;
  const HomeScreen({super.key, required this.isMovie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black, // Deep Matte Black
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/images/logo.png', height: 32, errorBuilder: (_,__,___) => Text(isMovie ? "MOVIES" : "TV SHOWS", style: const TextStyle(letterSpacing: 4, fontWeight: FontWeight.w900))),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
               showSearch(context: context, delegate: _HomeSearchDelegate(ref, isMovie));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             _HeroSection(isMovie: isMovie),
             const SizedBox(height: 24),
             _ContinueWatchingRail(isMovie: isMovie),
             const SizedBox(height: 24),
             
             // Available Rail (Local)
             if (isMovie)
               _ContentRail(title: "Available Movies", provider: availableMoviesRailProvider)
             else
               _ContentRail(title: "Available Series", provider: availableSeriesRailProvider),
               
             const SizedBox(height: 16),
             
             // Discovery Rails (TMDB)
             if (isMovie) ...[
                _ContentRail(title: "Trending Movies", provider: trendingMoviesRailProvider),
                const SizedBox(height: 16),
                _ContentRail(title: "Popular Movies", provider: popularMoviesRailProvider),
             ] else ...[
                _ContentRail(title: "Trending Series", provider: trendingSeriesRailProvider),
                const SizedBox(height: 16),
                _ContentRail(title: "Popular Series", provider: popularSeriesRailProvider),
             ],

             const SizedBox(height: 80), // Padding for nav bar
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends ConsumerWidget {
  final bool isMovie;
  const _HeroSection({required this.isMovie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredContentProvider(isMovie));

    return featuredAsync.when(
      data: (featured) {
         if (featured == null) return SizedBox(height: 400, child: Center(child: Text("No ${isMovie ? 'Movies' : 'TV Shows'} Found")));
         
         final imageUrl = featured.backdropUrl ?? featured.posterUrl;
         
         return SizedBox(
           height: 500,
           child: Stack(
             fit: StackFit.expand,
             children: [
               // Background Image
               if (imageUrl != null)
                 CachedNetworkImage(
                   imageUrl: imageUrl.startsWith('http') ? imageUrl : "https://image.tmdb.org/t/p/original$imageUrl",
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
                      // Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           // Play button only if it has contentId AND likely is available (from feature? logic is mixed)
                           // Hero can be Available or Trending.
                           // Play button is safe if we launch VideoLauncher which handles check or plays local path if known
                           FilledButton.icon(
                             style: FilledButton.styleFrom(
                               backgroundColor: Colors.white, 
                               foregroundColor: Colors.black,
                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                             ),
                             onPressed: () {
                                VideoLauncher.launch(
                                  context,
                                  ref,
                                  featured.isMovie ? (featured.originalItem as dynamic).path ?? '' : '', // Path might be empty for trending
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
  final bool isMovie;
  const _ContinueWatchingRail({required this.isMovie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(continueWatchingRailProvider);
    
    return listAsync.when(
       data: (items) {
          // Filter match
          final filtered = items.where((i) => i.isMovie == isMovie).toList();
          if (filtered.isEmpty) return const SizedBox.shrink();

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
                   itemCount: filtered.length,
                   separatorBuilder: (_,__) => const SizedBox(width: 12),
                   itemBuilder: (context, index) {
                      final item = filtered[index];
                      return GestureDetector(
                        onTap: () {
                           VideoLauncher.launch(
                             context,
                             ref,
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
                               image: NetworkImage(item.backdropUrl!.startsWith('http') ? item.backdropUrl! : "https://image.tmdb.org/t/p/w500${item.backdropUrl}"),
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
                                    imageUrl: posterUrl.startsWith('http') ? posterUrl : "https://image.tmdb.org/t/p/w500$posterUrl",
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

// --- SEARCH DELEGATE ---

class _HomeSearchDelegate extends SearchDelegate {
  final WidgetRef ref;
  final bool isMovie;
  _HomeSearchDelegate(this.ref, this.isMovie);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();
    
    // TMDB Search
    final searchFuture = ref.read(tmdbServiceProvider)?.search(query);

    return FutureBuilder<List<dynamic>>(
      future: searchFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
        
        final results = snapshot.data ?? [];
        // Filter by type if needed? Or show both?
        // User asked to split Home. But Search should probably search relevant type or Both.
        // Let's filter by 'media_type' if available, or just show all but differentiate.
        // TMDB 'multi' search returns media_type.
        
        final filtered = results.where((i) {
           final type = i['media_type'];
           if (type == 'person') return false;
           // If we seek strict separation:
           // if (isMovie && type == 'tv') return false; 
           // if (!isMovie && type == 'movie') return false;
           return true; 
        }).toList();

        if (filtered.isEmpty) return const Center(child: Text("No results found", style: TextStyle(color: Colors.white)));
        
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          separatorBuilder: (_,__) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = filtered[index];
            final type = item['media_type'];
            final isItemMovie = type == 'movie' || (item['title'] != null); // Fallback logic
            
            final title = item['title'] ?? item['name'] ?? 'Unknown';
            final posterPath = item['poster_path'];
            final overview = item['overview'] ?? '';
            final id = item['id'];

            return ListTile(
              leading: posterPath != null 
                 ? CachedNetworkImage(imageUrl: "https://image.tmdb.org/t/p/w200$posterPath", width: 50, fit: BoxFit.cover)
                 : const SizedBox(width: 50, height: 75, child: Icon(Icons.movie, color: Colors.grey)),
              title: Text(title, style: const TextStyle(color: Colors.white)),
              subtitle: Text(isItemMovie ? "Movie" : "Series", style: const TextStyle(color: Colors.tealAccent)),
                  onTap: () {
                     // close(context, null); // Keep search open? Or close. Usually close.
                     // But we want to show details.
                     
                     if (isItemMovie) {
                        final movie = Movie(
                          id: -id, // Negative ID for remote
                          tmdbId: id,
                          title: title,
                          overview: overview,
                          path: '',
                          hasFile: false,
                          sizeOnDisk: 0,
                          images: posterPath != null ? [MovieImage(coverType: 'poster', url: '', remoteUrl: "https://image.tmdb.org/t/p/w500$posterPath")] : [],
                        );
                        showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => MovieDetailBottomSheet(movie: movie));
                     } else {
                        final series = Series(
                          id: -id,
                          tmdbId: id,
                          title: title,
                          overview: overview,
                          path: '',
                          images: posterPath != null ? [SeriesImage(coverType: 'poster', url: '', remoteUrl: "https://image.tmdb.org/t/p/w500$posterPath")] : [],
                          episodeCount: 0, 
                          episodeFileCount: 0,
                        );
                        showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => SeriesDetailBottomSheet(series: series));
                     }
                  },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      return const SizedBox.shrink();
  }
}
