// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarHash() => r'a390930a4ba485616b5c0eaf4d313f4c372a162d';

/// See also [isar].
@ProviderFor(isar)
final isarProvider = Provider<Isar>.internal(
  isar,
  name: r'isarProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isarHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsarRef = ProviderRef<Isar>;
String _$dioHash() => r'58eeefbd0832498ca2574c1fe69ed783c58d1d8f';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$radarrServiceHash() => r'2230ab3415487703958bd31ae3cf389c75aaa6b7';

/// See also [radarrService].
@ProviderFor(radarrService)
final radarrServiceProvider = AutoDisposeProvider<RadarrService?>.internal(
  radarrService,
  name: r'radarrServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$radarrServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RadarrServiceRef = AutoDisposeProviderRef<RadarrService?>;
String _$sonarrServiceHash() => r'2d502b61efa24feaabc0a0fe2349b6477eef5c19';

/// See also [sonarrService].
@ProviderFor(sonarrService)
final sonarrServiceProvider = AutoDisposeProvider<SonarrService?>.internal(
  sonarrService,
  name: r'sonarrServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sonarrServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SonarrServiceRef = AutoDisposeProviderRef<SonarrService?>;
String _$tmdbServiceHash() => r'fbbc16b920649334ecf5af4a979ee326a2d057a6';

/// See also [tmdbService].
@ProviderFor(tmdbService)
final tmdbServiceProvider = AutoDisposeProvider<TmdbService?>.internal(
  tmdbService,
  name: r'tmdbServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tmdbServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TmdbServiceRef = AutoDisposeProviderRef<TmdbService?>;
String _$libraryRepositoryHash() => r'7b98b637f7ffd3410957178fbd3a458713fe6196';

/// See also [libraryRepository].
@ProviderFor(libraryRepository)
final libraryRepositoryProvider =
    AutoDisposeProvider<LibraryRepository>.internal(
  libraryRepository,
  name: r'libraryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$libraryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryRepositoryRef = AutoDisposeProviderRef<LibraryRepository>;
String _$fetchMoviesHash() => r'ec4a9633fd6ed2b9ba44719f8f0bcbdfde449f62';

/// See also [fetchMovies].
@ProviderFor(fetchMovies)
final fetchMoviesProvider = AutoDisposeFutureProvider<List<Movie>>.internal(
  fetchMovies,
  name: r'fetchMoviesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchMoviesRef = AutoDisposeFutureProviderRef<List<Movie>>;
String _$fetchSeriesHash() => r'abc1d216e0eccac063e0841da76e64ba575502f5';

/// See also [fetchSeries].
@ProviderFor(fetchSeries)
final fetchSeriesProvider = AutoDisposeFutureProvider<List<Series>>.internal(
  fetchSeries,
  name: r'fetchSeriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchSeriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchSeriesRef = AutoDisposeFutureProviderRef<List<Series>>;
String _$fetchEpisodesHash() => r'41171cbf4ec69dbae71ca7a9af89bf83387d8e08';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchEpisodes].
@ProviderFor(fetchEpisodes)
const fetchEpisodesProvider = FetchEpisodesFamily();

/// See also [fetchEpisodes].
class FetchEpisodesFamily extends Family<AsyncValue<List<Episode>>> {
  /// See also [fetchEpisodes].
  const FetchEpisodesFamily();

  /// See also [fetchEpisodes].
  FetchEpisodesProvider call(
    int seriesId,
  ) {
    return FetchEpisodesProvider(
      seriesId,
    );
  }

  @override
  FetchEpisodesProvider getProviderOverride(
    covariant FetchEpisodesProvider provider,
  ) {
    return call(
      provider.seriesId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchEpisodesProvider';
}

/// See also [fetchEpisodes].
class FetchEpisodesProvider extends AutoDisposeFutureProvider<List<Episode>> {
  /// See also [fetchEpisodes].
  FetchEpisodesProvider(
    int seriesId,
  ) : this._internal(
          (ref) => fetchEpisodes(
            ref as FetchEpisodesRef,
            seriesId,
          ),
          from: fetchEpisodesProvider,
          name: r'fetchEpisodesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchEpisodesHash,
          dependencies: FetchEpisodesFamily._dependencies,
          allTransitiveDependencies:
              FetchEpisodesFamily._allTransitiveDependencies,
          seriesId: seriesId,
        );

  FetchEpisodesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.seriesId,
  }) : super.internal();

  final int seriesId;

  @override
  Override overrideWith(
    FutureOr<List<Episode>> Function(FetchEpisodesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchEpisodesProvider._internal(
        (ref) => create(ref as FetchEpisodesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        seriesId: seriesId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Episode>> createElement() {
    return _FetchEpisodesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchEpisodesProvider && other.seriesId == seriesId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, seriesId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchEpisodesRef on AutoDisposeFutureProviderRef<List<Episode>> {
  /// The parameter `seriesId` of this provider.
  int get seriesId;
}

class _FetchEpisodesProviderElement
    extends AutoDisposeFutureProviderElement<List<Episode>>
    with FetchEpisodesRef {
  _FetchEpisodesProviderElement(super.provider);

  @override
  int get seriesId => (origin as FetchEpisodesProvider).seriesId;
}

String _$fetchAvailableContentHash() =>
    r'6f5b7b03dd9fd6c8e9d84ebec3c4caf3ddcdbbf9';

/// See also [fetchAvailableContent].
@ProviderFor(fetchAvailableContent)
final fetchAvailableContentProvider =
    AutoDisposeFutureProvider<Set<int>>.internal(
  fetchAvailableContent,
  name: r'fetchAvailableContentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAvailableContentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAvailableContentRef = AutoDisposeFutureProviderRef<Set<int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
