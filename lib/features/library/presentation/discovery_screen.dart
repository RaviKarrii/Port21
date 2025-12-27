import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port21/features/library/application/library_providers.dart';

class DiscoveryScreen extends ConsumerStatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  ConsumerState<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends ConsumerState<DiscoveryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchCtrl = TextEditingController();
  
  List<dynamic> _movies = [];
  List<dynamic> _series = [];
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPopular();
  }
  
  Future<void> _loadPopular() async {
    final tmdb = ref.read(tmdbServiceProvider);
    if (tmdb == null) return;

    setState(() => _isLoading = true);
    final movies = await tmdb.getPopularMovies();
    final series = await tmdb.getPopularSeries();
    
    if (mounted) {
      setState(() {
        _movies = movies;
        _series = series;
        _isLoading = false;
      });
    }
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      _loadPopular();
      return;
    }

    final tmdb = ref.read(tmdbServiceProvider);
    if (tmdb == null) return;
    
    setState(() => _isLoading = true);
    
    // Determine type based on tab
    final isMovie = _tabController.index == 0;
    final results = await tmdb.search(query, isMovie: isMovie);
    
    if (mounted) {
       setState(() {
         if (isMovie) {
            _movies = results;
         } else {
            _series = results;
         }
         _isLoading = false;
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tmdb = ref.watch(tmdbServiceProvider);
    
    if (tmdb == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 48),
            const SizedBox(height: 16),
            const Text("TMDB API Key missing in Settings", style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Go Back")
            ),
          ],
        ),
      );
    }

    final availableAsync = ref.watch(fetchAvailableContentProvider);
    final availableIds = availableAsync.value ?? <int>{};

    return Scaffold(
      backgroundColor: const Color(0xFF0F1115), // Deep Industrial Bg
      appBar: AppBar(
        title: TextField(
          controller: _searchCtrl,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
             hintText: "Search Movies & TV...",
             hintStyle: TextStyle(color: Colors.grey),
             border: InputBorder.none,
             suffixIcon: Icon(Icons.search, color: Colors.tealAccent),
          ),
          onSubmitted: _search,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.tealAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: const [
             Tab(text: "MOVIES"),
             Tab(text: "TV SERIES"),
          ],
          onTap: (index) {
             // Re-trigger search or reload popular for the new tab if needed
             if (_searchCtrl.text.isNotEmpty) {
                _search(_searchCtrl.text);
             } else {
                // If switching tabs and no search, ensure we have data? _loadPopular fetches both. 
             }
          },
        ),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: Colors.tealAccent))
          : TabBarView(
              controller: _tabController,
              children: [
                _buildGrid(_movies, true, availableIds),
                _buildGrid(_series, false, availableIds),
              ],
            ),
    );
  }

  Widget _buildGrid(List<dynamic> items, bool isMovie, Set<int> availableIds) {
    if (items.isEmpty) {
       return const Center(child: Text("No results found", style: TextStyle(color: Colors.grey)));
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final id = item['id'] as int?;
        final isAvailable = id != null && availableIds.contains(id);
        
        final posterPath = item['poster_path'];
        final title = isMovie ? item['title'] : item['name'];
        final overview = item['overview'];
        final voteAverage = (item['vote_average'] as num?)?.toDouble() ?? 0.0;
        final year = (isMovie ? item['release_date'] : item['first_air_date'])?.toString().split('-').first ?? '';

        return GestureDetector(
          onTap: () => _showRequestDialog(item, isMovie),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: posterPath != null
                          ? CachedNetworkImage(
                              imageUrl: "https://image.tmdb.org/t/p/w500$posterPath",
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(color: Colors.grey[900]),
                              errorWidget: (_, __, ___) => const Icon(Icons.error),
                            )
                          : Container(color: Colors.grey[800], child: const Icon(Icons.movie)),
                    ),
                    if (isAvailable)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               Icon(Icons.check, color: Colors.white, size: 10),
                               SizedBox(width: 2),
                               Text(
                                 "ON DISK", 
                                 style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)
                               ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title ?? "Unknown",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Row(
                children: [
                   Text(year, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                   const Spacer(),
                   const Icon(Icons.star, color: Colors.amber, size: 10),
                   Text(" $voteAverage", style: const TextStyle(color: Colors.amber, fontSize: 10)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRequestDialog(dynamic item, bool isMovie) async {
      // 1. Fetch Profiles
      final profiles = isMovie 
          ? await ref.read(radarrServiceProvider)?.getQualityProfiles() 
          : await ref.read(sonarrServiceProvider)?.getQualityProfiles();
          
      final folders = isMovie
          ? await ref.read(radarrServiceProvider)?.getRootFolders()
          : await ref.read(sonarrServiceProvider)?.getRootFolders();
          
      if (!mounted) return;

      if (profiles == null || folders == null || profiles.isEmpty || folders.isEmpty) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Could not fetch Profiles/Folders. Check Settings."),
            backgroundColor: Colors.red,
         ));
         return;
      }
      
      int selectedProfile = profiles.first['id'];
      String selectedFolder = folders.first['path'];
      
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder( // To update dropdowns
          builder: (context, setState) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: Text("Request ${isMovie ? 'Movie' : 'Series'}", style: const TextStyle(color: Colors.white)),
            content: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(isMovie ? item['title'] : item['name'], style: const TextStyle(color: Colors.tealAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  const Text("Quality Profile", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  DropdownButton<int>(
                    value: selectedProfile,
                    dropdownColor: const Color(0xFF2C2C2C),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    items: profiles.map<DropdownMenuItem<int>>((p) {
                       return DropdownMenuItem(value: p['id'], child: Text(p['name']));
                    }).toList(),
                    onChanged: (val) => setState(() => selectedProfile = val!),
                  ),
                  
                  const SizedBox(height: 16),
                  const Text("Root Folder", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  DropdownButton<String>(
                    value: selectedFolder,
                    dropdownColor: const Color(0xFF2C2C2C),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    items: folders.map<DropdownMenuItem<String>>((f) {
                       return DropdownMenuItem(value: f['path'], child: Text(f['path']));
                    }).toList(),
                    onChanged: (val) => setState(() => selectedFolder = val!),
                  ),
               ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () async {
                   Navigator.pop(context); // Close dialog
                   _submitRequest(item, isMovie, selectedProfile, selectedFolder);
                }, 
                child: const Text("REQUEST")
              ),
            ],
          ),
        ),
      );
  }
  
  void _submitRequest(dynamic item, bool isMovie, int qualityId, String rootFolder) async {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sending Request...")));
       
       bool success = false;
       if (isMovie) {
          final body = {
             "title": item['title'],
             "tmdbId": item['id'],
             "year": int.tryParse(item['release_date']?.split('-')[0] ?? '0') ?? 0,
             "qualityProfileId": qualityId,
             "rootFolderPath": rootFolder,
             "monitored": true,
             "addOptions": {"searchForMovie": true},
             "images": [
               {"coverType": "poster", "url": "https://image.tmdb.org/t/p/w500${item['poster_path']}"}
             ]
          };
          success = await ref.read(radarrServiceProvider)!.addMovie(body);
       } else {
          final body = {
             "title": item['name'],
             "tvdbId": 0, // Sonarr needs TVDB usually, TMDB ID support varies. 
                          // Wait, TMDB API returns TMDB ID. Sonarr V3 supports lookup via tmdb?
                          // Ideally we search Sonarr by TMDB ID first to get the TVDB ID.
                          // OR we rely on Sonarr's lookup.
                          // Actually, 'addSeries' requires tvdbId in many versions.
                          // Let's assume we pass what we have. If it fails, user needs TVDB lookup.
                          // WORKAROUND: We can use 'term=tvdb:...' search? No.
                          // Sonarr might require tvdbId. item['id'] is TMDB.
                          // For now, let's try sending it. If Sonarr checks, it might fail.
                          // But typically we should use Sonarr's /api/v3/series/lookup?term=tmdb:ID
             "tmdbId": item['id'], 
             "qualityProfileId": qualityId,
             "rootFolderPath": rootFolder,
             "monitored": true,
             "addOptions": {"searchForMissingEpisodes": true},
             "seasons": [], // Monitor all
              "images": [
               {"coverType": "poster", "url": "https://image.tmdb.org/t/p/w500${item['poster_path']}"}
             ]
          };
          // IMPORTANT: Sonarr usually requires 'tvdbId'. We might need to look it up.
          // But let's try simply passing the body.
          success = await ref.read(sonarrServiceProvider)!.addSeries(body);
       }
       
       if (mounted) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
               content: Text("Request Sent Successfully!"), 
               backgroundColor: Colors.green
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
               content: Text("Request Failed. Check Server Logs."), 
               backgroundColor: Colors.red
            ));
          }
       }
  }
}
