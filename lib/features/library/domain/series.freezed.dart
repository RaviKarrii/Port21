// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'series.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return _Series.fromJson(json);
}

/// @nodoc
mixin _$Series {
  int get id => throw _privateConstructorUsedError;
  int get tvdbId => throw _privateConstructorUsedError;
  int get tmdbId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  List<SeriesImage> get images => throw _privateConstructorUsedError;
  int get episodeCount => throw _privateConstructorUsedError;
  int get episodeFileCount => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesCopyWith<Series> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesCopyWith<$Res> {
  factory $SeriesCopyWith(Series value, $Res Function(Series) then) =
      _$SeriesCopyWithImpl<$Res, Series>;
  @useResult
  $Res call(
      {int id,
      int tvdbId,
      int tmdbId,
      String title,
      String overview,
      List<SeriesImage> images,
      int episodeCount,
      int episodeFileCount,
      String? path,
      String? status});
}

/// @nodoc
class _$SeriesCopyWithImpl<$Res, $Val extends Series>
    implements $SeriesCopyWith<$Res> {
  _$SeriesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tvdbId = null,
    Object? tmdbId = null,
    Object? title = null,
    Object? overview = null,
    Object? images = null,
    Object? episodeCount = null,
    Object? episodeFileCount = null,
    Object? path = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tvdbId: null == tvdbId
          ? _value.tvdbId
          : tvdbId // ignore: cast_nullable_to_non_nullable
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
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<SeriesImage>,
      episodeCount: null == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int,
      episodeFileCount: null == episodeFileCount
          ? _value.episodeFileCount
          : episodeFileCount // ignore: cast_nullable_to_non_nullable
              as int,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeriesImplCopyWith<$Res> implements $SeriesCopyWith<$Res> {
  factory _$$SeriesImplCopyWith(
          _$SeriesImpl value, $Res Function(_$SeriesImpl) then) =
      __$$SeriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int tvdbId,
      int tmdbId,
      String title,
      String overview,
      List<SeriesImage> images,
      int episodeCount,
      int episodeFileCount,
      String? path,
      String? status});
}

/// @nodoc
class __$$SeriesImplCopyWithImpl<$Res>
    extends _$SeriesCopyWithImpl<$Res, _$SeriesImpl>
    implements _$$SeriesImplCopyWith<$Res> {
  __$$SeriesImplCopyWithImpl(
      _$SeriesImpl _value, $Res Function(_$SeriesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tvdbId = null,
    Object? tmdbId = null,
    Object? title = null,
    Object? overview = null,
    Object? images = null,
    Object? episodeCount = null,
    Object? episodeFileCount = null,
    Object? path = freezed,
    Object? status = freezed,
  }) {
    return _then(_$SeriesImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tvdbId: null == tvdbId
          ? _value.tvdbId
          : tvdbId // ignore: cast_nullable_to_non_nullable
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
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<SeriesImage>,
      episodeCount: null == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int,
      episodeFileCount: null == episodeFileCount
          ? _value.episodeFileCount
          : episodeFileCount // ignore: cast_nullable_to_non_nullable
              as int,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeriesImpl implements _Series {
  const _$SeriesImpl(
      {required this.id,
      this.tvdbId = 0,
      this.tmdbId = 0,
      required this.title,
      this.overview = '',
      final List<SeriesImage> images = const [],
      this.episodeCount = 0,
      this.episodeFileCount = 0,
      this.path,
      this.status})
      : _images = images;

  factory _$SeriesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeriesImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final int tvdbId;
  @override
  @JsonKey()
  final int tmdbId;
  @override
  final String title;
  @override
  @JsonKey()
  final String overview;
  final List<SeriesImage> _images;
  @override
  @JsonKey()
  List<SeriesImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final int episodeCount;
  @override
  @JsonKey()
  final int episodeFileCount;
  @override
  final String? path;
  @override
  final String? status;

  @override
  String toString() {
    return 'Series(id: $id, tvdbId: $tvdbId, tmdbId: $tmdbId, title: $title, overview: $overview, images: $images, episodeCount: $episodeCount, episodeFileCount: $episodeFileCount, path: $path, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeriesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tvdbId, tvdbId) || other.tvdbId == tvdbId) &&
            (identical(other.tmdbId, tmdbId) || other.tmdbId == tmdbId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.episodeCount, episodeCount) ||
                other.episodeCount == episodeCount) &&
            (identical(other.episodeFileCount, episodeFileCount) ||
                other.episodeFileCount == episodeFileCount) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tvdbId,
      tmdbId,
      title,
      overview,
      const DeepCollectionEquality().hash(_images),
      episodeCount,
      episodeFileCount,
      path,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeriesImplCopyWith<_$SeriesImpl> get copyWith =>
      __$$SeriesImplCopyWithImpl<_$SeriesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeriesImplToJson(
      this,
    );
  }
}

abstract class _Series implements Series {
  const factory _Series(
      {required final int id,
      final int tvdbId,
      final int tmdbId,
      required final String title,
      final String overview,
      final List<SeriesImage> images,
      final int episodeCount,
      final int episodeFileCount,
      final String? path,
      final String? status}) = _$SeriesImpl;

  factory _Series.fromJson(Map<String, dynamic> json) = _$SeriesImpl.fromJson;

  @override
  int get id;
  @override
  int get tvdbId;
  @override
  int get tmdbId;
  @override
  String get title;
  @override
  String get overview;
  @override
  List<SeriesImage> get images;
  @override
  int get episodeCount;
  @override
  int get episodeFileCount;
  @override
  String? get path;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$SeriesImplCopyWith<_$SeriesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeriesImage _$SeriesImageFromJson(Map<String, dynamic> json) {
  return _SeriesImage.fromJson(json);
}

/// @nodoc
mixin _$SeriesImage {
  String get coverType => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get remoteUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesImageCopyWith<SeriesImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesImageCopyWith<$Res> {
  factory $SeriesImageCopyWith(
          SeriesImage value, $Res Function(SeriesImage) then) =
      _$SeriesImageCopyWithImpl<$Res, SeriesImage>;
  @useResult
  $Res call({String coverType, String url, String? remoteUrl});
}

/// @nodoc
class _$SeriesImageCopyWithImpl<$Res, $Val extends SeriesImage>
    implements $SeriesImageCopyWith<$Res> {
  _$SeriesImageCopyWithImpl(this._value, this._then);

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
abstract class _$$SeriesImageImplCopyWith<$Res>
    implements $SeriesImageCopyWith<$Res> {
  factory _$$SeriesImageImplCopyWith(
          _$SeriesImageImpl value, $Res Function(_$SeriesImageImpl) then) =
      __$$SeriesImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String coverType, String url, String? remoteUrl});
}

/// @nodoc
class __$$SeriesImageImplCopyWithImpl<$Res>
    extends _$SeriesImageCopyWithImpl<$Res, _$SeriesImageImpl>
    implements _$$SeriesImageImplCopyWith<$Res> {
  __$$SeriesImageImplCopyWithImpl(
      _$SeriesImageImpl _value, $Res Function(_$SeriesImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverType = null,
    Object? url = null,
    Object? remoteUrl = freezed,
  }) {
    return _then(_$SeriesImageImpl(
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
class _$SeriesImageImpl implements _SeriesImage {
  const _$SeriesImageImpl(
      {required this.coverType, required this.url, this.remoteUrl});

  factory _$SeriesImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeriesImageImplFromJson(json);

  @override
  final String coverType;
  @override
  final String url;
  @override
  final String? remoteUrl;

  @override
  String toString() {
    return 'SeriesImage(coverType: $coverType, url: $url, remoteUrl: $remoteUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeriesImageImpl &&
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
  _$$SeriesImageImplCopyWith<_$SeriesImageImpl> get copyWith =>
      __$$SeriesImageImplCopyWithImpl<_$SeriesImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeriesImageImplToJson(
      this,
    );
  }
}

abstract class _SeriesImage implements SeriesImage {
  const factory _SeriesImage(
      {required final String coverType,
      required final String url,
      final String? remoteUrl}) = _$SeriesImageImpl;

  factory _SeriesImage.fromJson(Map<String, dynamic> json) =
      _$SeriesImageImpl.fromJson;

  @override
  String get coverType;
  @override
  String get url;
  @override
  String? get remoteUrl;
  @override
  @JsonKey(ignore: true)
  _$$SeriesImageImplCopyWith<_$SeriesImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
