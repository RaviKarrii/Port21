// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_media.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDownloadedMediaCollection on Isar {
  IsarCollection<DownloadedMedia> get downloadedMedias => this.collection();
}

const DownloadedMediaSchema = CollectionSchema(
  name: r'DownloadedMedia',
  id: -245516043307894558,
  properties: {
    r'contentId': PropertySchema(
      id: 0,
      name: r'contentId',
      type: IsarType.string,
    ),
    r'downloadedAt': PropertySchema(
      id: 1,
      name: r'downloadedAt',
      type: IsarType.dateTime,
    ),
    r'path': PropertySchema(
      id: 2,
      name: r'path',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 3,
      name: r'status',
      type: IsarType.string,
    ),
    r'streamUrl': PropertySchema(
      id: 4,
      name: r'streamUrl',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _downloadedMediaEstimateSize,
  serialize: _downloadedMediaSerialize,
  deserialize: _downloadedMediaDeserialize,
  deserializeProp: _downloadedMediaDeserializeProp,
  idName: r'id',
  indexes: {
    r'contentId': IndexSchema(
      id: -332487537278013663,
      name: r'contentId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'contentId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _downloadedMediaGetId,
  getLinks: _downloadedMediaGetLinks,
  attach: _downloadedMediaAttach,
  version: '3.1.0+1',
);

int _downloadedMediaEstimateSize(
  DownloadedMedia object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentId.length * 3;
  bytesCount += 3 + object.path.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.streamUrl.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _downloadedMediaSerialize(
  DownloadedMedia object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contentId);
  writer.writeDateTime(offsets[1], object.downloadedAt);
  writer.writeString(offsets[2], object.path);
  writer.writeString(offsets[3], object.status);
  writer.writeString(offsets[4], object.streamUrl);
  writer.writeString(offsets[5], object.title);
}

DownloadedMedia _downloadedMediaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DownloadedMedia();
  object.contentId = reader.readString(offsets[0]);
  object.downloadedAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.path = reader.readString(offsets[2]);
  object.status = reader.readString(offsets[3]);
  object.streamUrl = reader.readString(offsets[4]);
  object.title = reader.readString(offsets[5]);
  return object;
}

P _downloadedMediaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _downloadedMediaGetId(DownloadedMedia object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _downloadedMediaGetLinks(DownloadedMedia object) {
  return [];
}

void _downloadedMediaAttach(
    IsarCollection<dynamic> col, Id id, DownloadedMedia object) {
  object.id = id;
}

extension DownloadedMediaByIndex on IsarCollection<DownloadedMedia> {
  Future<DownloadedMedia?> getByContentId(String contentId) {
    return getByIndex(r'contentId', [contentId]);
  }

  DownloadedMedia? getByContentIdSync(String contentId) {
    return getByIndexSync(r'contentId', [contentId]);
  }

  Future<bool> deleteByContentId(String contentId) {
    return deleteByIndex(r'contentId', [contentId]);
  }

  bool deleteByContentIdSync(String contentId) {
    return deleteByIndexSync(r'contentId', [contentId]);
  }

  Future<List<DownloadedMedia?>> getAllByContentId(
      List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'contentId', values);
  }

  List<DownloadedMedia?> getAllByContentIdSync(List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'contentId', values);
  }

  Future<int> deleteAllByContentId(List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'contentId', values);
  }

  int deleteAllByContentIdSync(List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'contentId', values);
  }

  Future<Id> putByContentId(DownloadedMedia object) {
    return putByIndex(r'contentId', object);
  }

  Id putByContentIdSync(DownloadedMedia object, {bool saveLinks = true}) {
    return putByIndexSync(r'contentId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByContentId(List<DownloadedMedia> objects) {
    return putAllByIndex(r'contentId', objects);
  }

  List<Id> putAllByContentIdSync(List<DownloadedMedia> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'contentId', objects, saveLinks: saveLinks);
  }
}

extension DownloadedMediaQueryWhereSort
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QWhere> {
  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DownloadedMediaQueryWhere
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QWhereClause> {
  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause>
      contentIdEqualTo(String contentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'contentId',
        value: [contentId],
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterWhereClause>
      contentIdNotEqualTo(String contentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [],
              upper: [contentId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [contentId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [contentId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [],
              upper: [contentId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DownloadedMediaQueryFilter
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QFilterCondition> {
  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      contentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentId',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      downloadedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      downloadedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downloadedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      downloadedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downloadedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      downloadedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downloadedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streamUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'streamUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      streamUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streamUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension DownloadedMediaQueryObject
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QFilterCondition> {}

extension DownloadedMediaQueryLinks
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QFilterCondition> {}

extension DownloadedMediaQuerySortBy
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QSortBy> {
  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByDownloadedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByStreamUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByStreamUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DownloadedMediaQuerySortThenBy
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QSortThenBy> {
  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByDownloadedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByStreamUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByStreamUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.desc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DownloadedMediaQueryWhereDistinct
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct> {
  QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct> distinctByContentId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct>
      distinctByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadedAt');
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct> distinctByStreamUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedMedia, DownloadedMedia, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension DownloadedMediaQueryProperty
    on QueryBuilder<DownloadedMedia, DownloadedMedia, QQueryProperty> {
  QueryBuilder<DownloadedMedia, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DownloadedMedia, String, QQueryOperations> contentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentId');
    });
  }

  QueryBuilder<DownloadedMedia, DateTime, QQueryOperations>
      downloadedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadedAt');
    });
  }

  QueryBuilder<DownloadedMedia, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<DownloadedMedia, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<DownloadedMedia, String, QQueryOperations> streamUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamUrl');
    });
  }

  QueryBuilder<DownloadedMedia, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
