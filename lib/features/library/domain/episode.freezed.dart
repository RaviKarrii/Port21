// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return _Episode.fromJson(json);
}

/// @nodoc
mixin _$Episode {
  int get id => throw _privateConstructorUsedError;
  int get seriesId => throw _privateConstructorUsedError;
  int get episodeFileId => throw _privateConstructorUsedError;
  int get seasonNumber => throw _privateConstructorUsedError;
  int get episodeNumber => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  int get sizeOnDisk => throw _privateConstructorUsedError; // Added
  bool get hasFile => throw _privateConstructorUsedError;
  DateTime? get airDateUtc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EpisodeCopyWith<Episode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) then) =
      _$EpisodeCopyWithImpl<$Res, Episode>;
  @useResult
  $Res call(
      {int id,
      int seriesId,
      int episodeFileId,
      int seasonNumber,
      int episodeNumber,
      String? title,
      String? overview,
      String? path,
      int sizeOnDisk,
      bool hasFile,
      DateTime? airDateUtc});
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res, $Val extends Episode>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seriesId = null,
    Object? episodeFileId = null,
    Object? seasonNumber = null,
    Object? episodeNumber = null,
    Object? title = freezed,
    Object? overview = freezed,
    Object? path = freezed,
    Object? sizeOnDisk = null,
    Object? hasFile = null,
    Object? airDateUtc = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seriesId: null == seriesId
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as int,
      episodeFileId: null == episodeFileId
          ? _value.episodeFileId
          : episodeFileId // ignore: cast_nullable_to_non_nullable
              as int,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      episodeNumber: null == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeOnDisk: null == sizeOnDisk
          ? _value.sizeOnDisk
          : sizeOnDisk // ignore: cast_nullable_to_non_nullable
              as int,
      hasFile: null == hasFile
          ? _value.hasFile
          : hasFile // ignore: cast_nullable_to_non_nullable
              as bool,
      airDateUtc: freezed == airDateUtc
          ? _value.airDateUtc
          : airDateUtc // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EpisodeImplCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$EpisodeImplCopyWith(
          _$EpisodeImpl value, $Res Function(_$EpisodeImpl) then) =
      __$$EpisodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int seriesId,
      int episodeFileId,
      int seasonNumber,
      int episodeNumber,
      String? title,
      String? overview,
      String? path,
      int sizeOnDisk,
      bool hasFile,
      DateTime? airDateUtc});
}

/// @nodoc
class __$$EpisodeImplCopyWithImpl<$Res>
    extends _$EpisodeCopyWithImpl<$Res, _$EpisodeImpl>
    implements _$$EpisodeImplCopyWith<$Res> {
  __$$EpisodeImplCopyWithImpl(
      _$EpisodeImpl _value, $Res Function(_$EpisodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seriesId = null,
    Object? episodeFileId = null,
    Object? seasonNumber = null,
    Object? episodeNumber = null,
    Object? title = freezed,
    Object? overview = freezed,
    Object? path = freezed,
    Object? sizeOnDisk = null,
    Object? hasFile = null,
    Object? airDateUtc = freezed,
  }) {
    return _then(_$EpisodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seriesId: null == seriesId
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as int,
      episodeFileId: null == episodeFileId
          ? _value.episodeFileId
          : episodeFileId // ignore: cast_nullable_to_non_nullable
              as int,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      episodeNumber: null == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeOnDisk: null == sizeOnDisk
          ? _value.sizeOnDisk
          : sizeOnDisk // ignore: cast_nullable_to_non_nullable
              as int,
      hasFile: null == hasFile
          ? _value.hasFile
          : hasFile // ignore: cast_nullable_to_non_nullable
              as bool,
      airDateUtc: freezed == airDateUtc
          ? _value.airDateUtc
          : airDateUtc // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EpisodeImpl implements _Episode {
  const _$EpisodeImpl(
      {required this.id,
      required this.seriesId,
      required this.episodeFileId,
      required this.seasonNumber,
      required this.episodeNumber,
      this.title,
      this.overview,
      this.path,
      this.sizeOnDisk = 0,
      this.hasFile = false,
      this.airDateUtc});

  factory _$EpisodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpisodeImplFromJson(json);

  @override
  final int id;
  @override
  final int seriesId;
  @override
  final int episodeFileId;
  @override
  final int seasonNumber;
  @override
  final int episodeNumber;
  @override
  final String? title;
  @override
  final String? overview;
  @override
  final String? path;
  @override
  @JsonKey()
  final int sizeOnDisk;
// Added
  @override
  @JsonKey()
  final bool hasFile;
  @override
  final DateTime? airDateUtc;

  @override
  String toString() {
    return 'Episode(id: $id, seriesId: $seriesId, episodeFileId: $episodeFileId, seasonNumber: $seasonNumber, episodeNumber: $episodeNumber, title: $title, overview: $overview, path: $path, sizeOnDisk: $sizeOnDisk, hasFile: $hasFile, airDateUtc: $airDateUtc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seriesId, seriesId) ||
                other.seriesId == seriesId) &&
            (identical(other.episodeFileId, episodeFileId) ||
                other.episodeFileId == episodeFileId) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.episodeNumber, episodeNumber) ||
                other.episodeNumber == episodeNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.sizeOnDisk, sizeOnDisk) ||
                other.sizeOnDisk == sizeOnDisk) &&
            (identical(other.hasFile, hasFile) || other.hasFile == hasFile) &&
            (identical(other.airDateUtc, airDateUtc) ||
                other.airDateUtc == airDateUtc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      seriesId,
      episodeFileId,
      seasonNumber,
      episodeNumber,
      title,
      overview,
      path,
      sizeOnDisk,
      hasFile,
      airDateUtc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      __$$EpisodeImplCopyWithImpl<_$EpisodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpisodeImplToJson(
      this,
    );
  }
}

abstract class _Episode implements Episode {
  const factory _Episode(
      {required final int id,
      required final int seriesId,
      required final int episodeFileId,
      required final int seasonNumber,
      required final int episodeNumber,
      final String? title,
      final String? overview,
      final String? path,
      final int sizeOnDisk,
      final bool hasFile,
      final DateTime? airDateUtc}) = _$EpisodeImpl;

  factory _Episode.fromJson(Map<String, dynamic> json) = _$EpisodeImpl.fromJson;

  @override
  int get id;
  @override
  int get seriesId;
  @override
  int get episodeFileId;
  @override
  int get seasonNumber;
  @override
  int get episodeNumber;
  @override
  String? get title;
  @override
  String? get overview;
  @override
  String? get path;
  @override
  int get sizeOnDisk;
  @override // Added
  bool get hasFile;
  @override
  DateTime? get airDateUtc;
  @override
  @JsonKey(ignore: true)
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
