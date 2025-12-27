// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
mixin _$Movie {
  int get id => throw _privateConstructorUsedError;
  int get tmdbId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError; // remotePath
  List<MovieImage> get images => throw _privateConstructorUsedError;
  bool get hasFile => throw _privateConstructorUsedError;
  int get sizeOnDisk => throw _privateConstructorUsedError;
  int get runtime => throw _privateConstructorUsedError;
  DateTime? get added => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
  @useResult
  $Res call(
      {int id,
      int tmdbId,
      String title,
      String overview,
      String? path,
      List<MovieImage> images,
      bool hasFile,
      int sizeOnDisk,
      int runtime,
      DateTime? added});
}

/// @nodoc
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tmdbId = null,
    Object? title = null,
    Object? overview = null,
    Object? path = freezed,
    Object? images = null,
    Object? hasFile = null,
    Object? sizeOnDisk = null,
    Object? runtime = null,
    Object? added = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tmdbId: null == tmdbId
          ? _value.tmdbId
          : tmdbId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<MovieImage>,
      hasFile: null == hasFile
          ? _value.hasFile
          : hasFile // ignore: cast_nullable_to_non_nullable
              as bool,
      sizeOnDisk: null == sizeOnDisk
          ? _value.sizeOnDisk
          : sizeOnDisk // ignore: cast_nullable_to_non_nullable
              as int,
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      added: freezed == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieImplCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$MovieImplCopyWith(
          _$MovieImpl value, $Res Function(_$MovieImpl) then) =
      __$$MovieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int tmdbId,
      String title,
      String overview,
      String? path,
      List<MovieImage> images,
      bool hasFile,
      int sizeOnDisk,
      int runtime,
      DateTime? added});
}

/// @nodoc
class __$$MovieImplCopyWithImpl<$Res>
    extends _$MovieCopyWithImpl<$Res, _$MovieImpl>
    implements _$$MovieImplCopyWith<$Res> {
  __$$MovieImplCopyWithImpl(
      _$MovieImpl _value, $Res Function(_$MovieImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tmdbId = null,
    Object? title = null,
    Object? overview = null,
    Object? path = freezed,
    Object? images = null,
    Object? hasFile = null,
    Object? sizeOnDisk = null,
    Object? runtime = null,
    Object? added = freezed,
  }) {
    return _then(_$MovieImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tmdbId: null == tmdbId
          ? _value.tmdbId
          : tmdbId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<MovieImage>,
      hasFile: null == hasFile
          ? _value.hasFile
          : hasFile // ignore: cast_nullable_to_non_nullable
              as bool,
      sizeOnDisk: null == sizeOnDisk
          ? _value.sizeOnDisk
          : sizeOnDisk // ignore: cast_nullable_to_non_nullable
              as int,
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      added: freezed == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieImpl implements _Movie {
  const _$MovieImpl(
      {required this.id,
      this.tmdbId = 0,
      required this.title,
      this.overview = '',
      this.path,
      final List<MovieImage> images = const [],
      this.hasFile = false,
      this.sizeOnDisk = 0,
      this.runtime = 0,
      this.added})
      : _images = images;

  factory _$MovieImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final int tmdbId;
  @override
  final String title;
  @override
  @JsonKey()
  final String overview;
  @override
  final String? path;
// remotePath
  final List<MovieImage> _images;
// remotePath
  @override
  @JsonKey()
  List<MovieImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final bool hasFile;
  @override
  @JsonKey()
  final int sizeOnDisk;
  @override
  @JsonKey()
  final int runtime;
  @override
  final DateTime? added;

  @override
  String toString() {
    return 'Movie(id: $id, tmdbId: $tmdbId, title: $title, overview: $overview, path: $path, images: $images, hasFile: $hasFile, sizeOnDisk: $sizeOnDisk, runtime: $runtime, added: $added)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tmdbId, tmdbId) || other.tmdbId == tmdbId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.hasFile, hasFile) || other.hasFile == hasFile) &&
            (identical(other.sizeOnDisk, sizeOnDisk) ||
                other.sizeOnDisk == sizeOnDisk) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.added, added) || other.added == added));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tmdbId,
      title,
      overview,
      path,
      const DeepCollectionEquality().hash(_images),
      hasFile,
      sizeOnDisk,
      runtime,
      added);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      __$$MovieImplCopyWithImpl<_$MovieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieImplToJson(
      this,
    );
  }
}

abstract class _Movie implements Movie {
  const factory _Movie(
      {required final int id,
      final int tmdbId,
      required final String title,
      final String overview,
      final String? path,
      final List<MovieImage> images,
      final bool hasFile,
      final int sizeOnDisk,
      final int runtime,
      final DateTime? added}) = _$MovieImpl;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$MovieImpl.fromJson;

  @override
  int get id;
  @override
  int get tmdbId;
  @override
  String get title;
  @override
  String get overview;
  @override
  String? get path;
  @override // remotePath
  List<MovieImage> get images;
  @override
  bool get hasFile;
  @override
  int get sizeOnDisk;
  @override
  int get runtime;
  @override
  DateTime? get added;
  @override
  @JsonKey(ignore: true)
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MovieImage _$MovieImageFromJson(Map<String, dynamic> json) {
  return _MovieImage.fromJson(json);
}

/// @nodoc
mixin _$MovieImage {
  String get coverType => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get remoteUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieImageCopyWith<MovieImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieImageCopyWith<$Res> {
  factory $MovieImageCopyWith(
          MovieImage value, $Res Function(MovieImage) then) =
      _$MovieImageCopyWithImpl<$Res, MovieImage>;
  @useResult
  $Res call({String coverType, String url, String? remoteUrl});
}

/// @nodoc
class _$MovieImageCopyWithImpl<$Res, $Val extends MovieImage>
    implements $MovieImageCopyWith<$Res> {
  _$MovieImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverType = null,
    Object? url = null,
    Object? remoteUrl = freezed,
  }) {
    return _then(_value.copyWith(
      coverType: null == coverType
          ? _value.coverType
          : coverType // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      remoteUrl: freezed == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieImageImplCopyWith<$Res>
    implements $MovieImageCopyWith<$Res> {
  factory _$$MovieImageImplCopyWith(
          _$MovieImageImpl value, $Res Function(_$MovieImageImpl) then) =
      __$$MovieImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String coverType, String url, String? remoteUrl});
}

/// @nodoc
class __$$MovieImageImplCopyWithImpl<$Res>
    extends _$MovieImageCopyWithImpl<$Res, _$MovieImageImpl>
    implements _$$MovieImageImplCopyWith<$Res> {
  __$$MovieImageImplCopyWithImpl(
      _$MovieImageImpl _value, $Res Function(_$MovieImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverType = null,
    Object? url = null,
    Object? remoteUrl = freezed,
  }) {
    return _then(_$MovieImageImpl(
      coverType: null == coverType
          ? _value.coverType
          : coverType // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      remoteUrl: freezed == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieImageImpl implements _MovieImage {
  const _$MovieImageImpl(
      {required this.coverType, required this.url, this.remoteUrl});

  factory _$MovieImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieImageImplFromJson(json);

  @override
  final String coverType;
  @override
  final String url;
  @override
  final String? remoteUrl;

  @override
  String toString() {
    return 'MovieImage(coverType: $coverType, url: $url, remoteUrl: $remoteUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieImageImpl &&
            (identical(other.coverType, coverType) ||
                other.coverType == coverType) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.remoteUrl, remoteUrl) ||
                other.remoteUrl == remoteUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, coverType, url, remoteUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieImageImplCopyWith<_$MovieImageImpl> get copyWith =>
      __$$MovieImageImplCopyWithImpl<_$MovieImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieImageImplToJson(
      this,
    );
  }
}

abstract class _MovieImage implements MovieImage {
  const factory _MovieImage(
      {required final String coverType,
      required final String url,
      final String? remoteUrl}) = _$MovieImageImpl;

  factory _MovieImage.fromJson(Map<String, dynamic> json) =
      _$MovieImageImpl.fromJson;

  @override
  String get coverType;
  @override
  String get url;
  @override
  String? get remoteUrl;
  @override
  @JsonKey(ignore: true)
  _$$MovieImageImplCopyWith<_$MovieImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
