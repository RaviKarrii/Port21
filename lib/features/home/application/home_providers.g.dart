// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableMoviesRailHash() =>
    r'61145dd42f01ce4b1e844ca8552ad3f7a28de937';

/// See also [availableMoviesRail].
@ProviderFor(availableMoviesRail)
final availableMoviesRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  availableMoviesRail,
  name: r'availableMoviesRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableMoviesRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvailableMoviesRailRef
    = AutoDisposeFutureProviderRef<List<HomeContent>>;
String _$availableSeriesRailHash() =>
    r'da5a24899e02576e59971e00298803ef93304fb2';

/// See also [availableSeriesRail].
@ProviderFor(availableSeriesRail)
final availableSeriesRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  availableSeriesRail,
  name: r'availableSeriesRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableSeriesRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvailableSeriesRailRef
    = AutoDisposeFutureProviderRef<List<HomeContent>>;
String _$trendingMoviesRailHash() =>
    r'5f3f479c8e4d136d00b90771004a7bf802b20df2';

/// See also [trendingMoviesRail].
@ProviderFor(trendingMoviesRail)
final trendingMoviesRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  trendingMoviesRail,
  name: r'trendingMoviesRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$trendingMoviesRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TrendingMoviesRailRef = AutoDisposeFutureProviderRef<List<HomeContent>>;
String _$trendingSeriesRailHash() =>
    r'8888220e601853b2e1a917df4947f66fc3752678';

/// See also [trendingSeriesRail].
@ProviderFor(trendingSeriesRail)
final trendingSeriesRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  trendingSeriesRail,
  name: r'trendingSeriesRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$trendingSeriesRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TrendingSeriesRailRef = AutoDisposeFutureProviderRef<List<HomeContent>>;
String _$popularMoviesRailHash() => r'978ccfb689c229872e02308cee0afe6e36989592';

/// See also [popularMoviesRail].
@ProviderFor(popularMoviesRail)
final popularMoviesRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  popularMoviesRail,
  name: r'popularMoviesRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularMoviesRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PopularMoviesRailRef = AutoDisposeFutureProviderRef<List<HomeContent>>;
String _$popularSeriesRailHash() => r'2223558ad4055e45411815ab9d489b545513059f';

/// See also [popularSeriesRail].
@ProviderFor(popularSeriesRail)
final popularSeriesRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  popularSeriesRail,
  name: r'popularSeriesRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularSeriesRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PopularSeriesRailRef = AutoDisposeFutureProviderRef<List<HomeContent>>;
String _$featuredContentHash() => r'1b1e7c9211998c2d731120580af5da9d38c291df';

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

/// See also [featuredContent].
@ProviderFor(featuredContent)
const featuredContentProvider = FeaturedContentFamily();

/// See also [featuredContent].
class FeaturedContentFamily extends Family<AsyncValue<HomeContent?>> {
  /// See also [featuredContent].
  const FeaturedContentFamily();

  /// See also [featuredContent].
  FeaturedContentProvider call(
    bool isMovie,
  ) {
    return FeaturedContentProvider(
      isMovie,
    );
  }

  @override
  FeaturedContentProvider getProviderOverride(
    covariant FeaturedContentProvider provider,
  ) {
    return call(
      provider.isMovie,
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
  String? get name => r'featuredContentProvider';
}

/// See also [featuredContent].
class FeaturedContentProvider extends AutoDisposeFutureProvider<HomeContent?> {
  /// See also [featuredContent].
  FeaturedContentProvider(
    bool isMovie,
  ) : this._internal(
          (ref) => featuredContent(
            ref as FeaturedContentRef,
            isMovie,
          ),
          from: featuredContentProvider,
          name: r'featuredContentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$featuredContentHash,
          dependencies: FeaturedContentFamily._dependencies,
          allTransitiveDependencies:
              FeaturedContentFamily._allTransitiveDependencies,
          isMovie: isMovie,
        );

  FeaturedContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isMovie,
  }) : super.internal();

  final bool isMovie;

  @override
  Override overrideWith(
    FutureOr<HomeContent?> Function(FeaturedContentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeaturedContentProvider._internal(
        (ref) => create(ref as FeaturedContentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isMovie: isMovie,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HomeContent?> createElement() {
    return _FeaturedContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeaturedContentProvider && other.isMovie == isMovie;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isMovie.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FeaturedContentRef on AutoDisposeFutureProviderRef<HomeContent?> {
  /// The parameter `isMovie` of this provider.
  bool get isMovie;
}

class _FeaturedContentProviderElement
    extends AutoDisposeFutureProviderElement<HomeContent?>
    with FeaturedContentRef {
  _FeaturedContentProviderElement(super.provider);

  @override
  bool get isMovie => (origin as FeaturedContentProvider).isMovie;
}

String _$continueWatchingRailHash() =>
    r'ec7858220c977a83f353be8110fd8348ec70ca9b';

/// See also [continueWatchingRail].
@ProviderFor(continueWatchingRail)
final continueWatchingRailProvider =
    AutoDisposeFutureProvider<List<HomeContent>>.internal(
  continueWatchingRail,
  name: r'continueWatchingRailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$continueWatchingRailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ContinueWatchingRailRef
    = AutoDisposeFutureProviderRef<List<HomeContent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
