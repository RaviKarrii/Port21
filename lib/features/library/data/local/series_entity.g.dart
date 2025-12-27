// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSeriesEntityCollection on Isar {
  IsarCollection<SeriesEntity> get seriesEntitys => this.collection();
}

const SeriesEntitySchema = CollectionSchema(
  name: r'SeriesEntity',
  id: -31518033632857401,
  properties: {
    r'episodeCount': PropertySchema(
      id: 0,
      name: r'episodeCount',
      type: IsarType.long,
    ),
    r'episodeFileCount': PropertySchema(
      id: 1,
      name: r'episodeFileCount',
      type: IsarType.long,
    ),
    r'images': PropertySchema(
      id: 2,
      name: r'images',
      type: IsarType.objectList,
      target: r'SeriesImageEntity',
    ),
    r'overview': PropertySchema(
      id: 3,
      name: r'overview',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 4,
      name: r'path',
      type: IsarType.string,
    ),
    r'sonarrId': PropertySchema(
      id: 5,
      name: r'sonarrId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 6,
      name: r'status',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    ),
    r'tmdbId': PropertySchema(
      id: 8,
      name: r'tmdbId',
      type: IsarType.long,
    ),
    r'tvdbId': PropertySchema(
      id: 9,
      name: r'tvdbId',
      type: IsarType.long,
    )
  },
  estimateSize: _seriesEntityEstimateSize,
  serialize: _seriesEntitySerialize,
  deserialize: _seriesEntityDeserialize,
  deserializeProp: _seriesEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'sonarrId': IndexSchema(
      id: 2831205532784325156,
      name: r'sonarrId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'sonarrId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'SeriesImageEntity': SeriesImageEntitySchema},
  getId: _seriesEntityGetId,
  getLinks: _seriesEntityGetLinks,
  attach: _seriesEntityAttach,
  version: '3.1.0+1',
);

int _seriesEntityEstimateSize(
  SeriesEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.images.length * 3;
  {
    final offsets = allOffsets[SeriesImageEntity]!;
    for (var i = 0; i < object.images.length; i++) {
      final value = object.images[i];
      bytesCount +=
          SeriesImageEntitySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.overview.length * 3;
  {
    final value = object.path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _seriesEntitySerialize(
  SeriesEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.episodeCount);
  writer.writeLong(offsets[1], object.episodeFileCount);
  writer.writeObjectList<SeriesImageEntity>(
    offsets[2],
    allOffsets,
    SeriesImageEntitySchema.serialize,
    object.images,
  );
  writer.writeString(offsets[3], object.overview);
  writer.writeString(offsets[4], object.path);
  writer.writeLong(offsets[5], object.sonarrId);
  writer.writeString(offsets[6], object.status);
  writer.writeString(offsets[7], object.title);
  writer.writeLong(offsets[8], object.tmdbId);
  writer.writeLong(offsets[9], object.tvdbId);
}

SeriesEntity _seriesEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SeriesEntity();
  object.episodeCount = reader.readLong(offsets[0]);
  object.episodeFileCount = reader.readLong(offsets[1]);
  object.id = id;
  object.images = reader.readObjectList<SeriesImageEntity>(
        offsets[2],
        SeriesImageEntitySchema.deserialize,
        allOffsets,
        SeriesImageEntity(),
      ) ??
      [];
  object.overview = reader.readString(offsets[3]);
  object.path = reader.readStringOrNull(offsets[4]);
  object.sonarrId = reader.readLong(offsets[5]);
  object.status = reader.readStringOrNull(offsets[6]);
  object.title = reader.readString(offsets[7]);
  object.tmdbId = reader.readLong(offsets[8]);
  object.tvdbId = reader.readLong(offsets[9]);
  return object;
}

P _seriesEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectList<SeriesImageEntity>(
            offset,
            SeriesImageEntitySchema.deserialize,
            allOffsets,
            SeriesImageEntity(),
          ) ??
          []) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _seriesEntityGetId(SeriesEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _seriesEntityGetLinks(SeriesEntity object) {
  return [];
}

void _seriesEntityAttach(
    IsarCollection<dynamic> col, Id id, SeriesEntity object) {
  object.id = id;
}

extension SeriesEntityByIndex on IsarCollection<SeriesEntity> {
  Future<SeriesEntity?> getBySonarrId(int sonarrId) {
    return getByIndex(r'sonarrId', [sonarrId]);
  }

  SeriesEntity? getBySonarrIdSync(int sonarrId) {
    return getByIndexSync(r'sonarrId', [sonarrId]);
  }

  Future<bool> deleteBySonarrId(int sonarrId) {
    return deleteByIndex(r'sonarrId', [sonarrId]);
  }

  bool deleteBySonarrIdSync(int sonarrId) {
    return deleteByIndexSync(r'sonarrId', [sonarrId]);
  }

  Future<List<SeriesEntity?>> getAllBySonarrId(List<int> sonarrIdValues) {
    final values = sonarrIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'sonarrId', values);
  }

  List<SeriesEntity?> getAllBySonarrIdSync(List<int> sonarrIdValues) {
    final values = sonarrIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'sonarrId', values);
  }

  Future<int> deleteAllBySonarrId(List<int> sonarrIdValues) {
    final values = sonarrIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'sonarrId', values);
  }

  int deleteAllBySonarrIdSync(List<int> sonarrIdValues) {
    final values = sonarrIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'sonarrId', values);
  }

  Future<Id> putBySonarrId(SeriesEntity object) {
    return putByIndex(r'sonarrId', object);
  }

  Id putBySonarrIdSync(SeriesEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'sonarrId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySonarrId(List<SeriesEntity> objects) {
    return putAllByIndex(r'sonarrId', objects);
  }

  List<Id> putAllBySonarrIdSync(List<SeriesEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'sonarrId', objects, saveLinks: saveLinks);
  }
}

extension SeriesEntityQueryWhereSort
    on QueryBuilder<SeriesEntity, SeriesEntity, QWhere> {
  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhere> anySonarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sonarrId'),
      );
    });
  }
}

extension SeriesEntityQueryWhere
    on QueryBuilder<SeriesEntity, SeriesEntity, QWhereClause> {
  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> sonarrIdEqualTo(
      int sonarrId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sonarrId',
        value: [sonarrId],
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause>
      sonarrIdNotEqualTo(int sonarrId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sonarrId',
              lower: [],
              upper: [sonarrId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sonarrId',
              lower: [sonarrId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sonarrId',
              lower: [sonarrId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sonarrId',
              lower: [],
              upper: [sonarrId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause>
      sonarrIdGreaterThan(
    int sonarrId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sonarrId',
        lower: [sonarrId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> sonarrIdLessThan(
    int sonarrId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sonarrId',
        lower: [],
        upper: [sonarrId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterWhereClause> sonarrIdBetween(
    int lowerSonarrId,
    int upperSonarrId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sonarrId',
        lower: [lowerSonarrId],
        includeLower: includeLower,
        upper: [upperSonarrId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SeriesEntityQueryFilter
    on QueryBuilder<SeriesEntity, SeriesEntity, QFilterCondition> {
  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodeCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeFileCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeFileCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeFileCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodeFileCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeFileCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodeFileCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      episodeFileCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodeFileCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      imagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      imagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      imagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      imagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      imagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      imagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overview',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'overview',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overview',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      overviewIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'overview',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      pathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathEqualTo(
    String? value, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      pathGreaterThan(
    String? value, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathLessThan(
    String? value, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathEndsWith(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      sonarrIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sonarrId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      sonarrIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sonarrId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      sonarrIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sonarrId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      sonarrIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sonarrId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> statusEqualTo(
    String? value, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusGreaterThan(
    String? value, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusLessThan(
    String? value, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> tmdbIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tmdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      tmdbIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tmdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      tmdbIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tmdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> tmdbIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tmdbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> tvdbIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tvdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      tvdbIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tvdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition>
      tvdbIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tvdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> tvdbIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tvdbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SeriesEntityQueryObject
    on QueryBuilder<SeriesEntity, SeriesEntity, QFilterCondition> {
  QueryBuilder<SeriesEntity, SeriesEntity, QAfterFilterCondition> imagesElement(
      FilterQuery<SeriesImageEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'images');
    });
  }
}

extension SeriesEntityQueryLinks
    on QueryBuilder<SeriesEntity, SeriesEntity, QFilterCondition> {}

extension SeriesEntityQuerySortBy
    on QueryBuilder<SeriesEntity, SeriesEntity, QSortBy> {
  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy>
      sortByEpisodeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy>
      sortByEpisodeFileCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeFileCount', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy>
      sortByEpisodeFileCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeFileCount', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByOverview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByOverviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortBySonarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonarrId', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortBySonarrIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonarrId', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByTmdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByTmdbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByTvdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tvdbId', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> sortByTvdbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tvdbId', Sort.desc);
    });
  }
}

extension SeriesEntityQuerySortThenBy
    on QueryBuilder<SeriesEntity, SeriesEntity, QSortThenBy> {
  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy>
      thenByEpisodeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy>
      thenByEpisodeFileCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeFileCount', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy>
      thenByEpisodeFileCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeFileCount', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByOverview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByOverviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenBySonarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonarrId', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenBySonarrIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonarrId', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByTmdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByTmdbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.desc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByTvdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tvdbId', Sort.asc);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QAfterSortBy> thenByTvdbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tvdbId', Sort.desc);
    });
  }
}

extension SeriesEntityQueryWhereDistinct
    on QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> {
  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeCount');
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct>
      distinctByEpisodeFileCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeFileCount');
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByOverview(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overview', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctBySonarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sonarrId');
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByTmdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tmdbId');
    });
  }

  QueryBuilder<SeriesEntity, SeriesEntity, QDistinct> distinctByTvdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tvdbId');
    });
  }
}

extension SeriesEntityQueryProperty
    on QueryBuilder<SeriesEntity, SeriesEntity, QQueryProperty> {
  QueryBuilder<SeriesEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SeriesEntity, int, QQueryOperations> episodeCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeCount');
    });
  }

  QueryBuilder<SeriesEntity, int, QQueryOperations> episodeFileCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeFileCount');
    });
  }

  QueryBuilder<SeriesEntity, List<SeriesImageEntity>, QQueryOperations>
      imagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'images');
    });
  }

  QueryBuilder<SeriesEntity, String, QQueryOperations> overviewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overview');
    });
  }

  QueryBuilder<SeriesEntity, String?, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<SeriesEntity, int, QQueryOperations> sonarrIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sonarrId');
    });
  }

  QueryBuilder<SeriesEntity, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<SeriesEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<SeriesEntity, int, QQueryOperations> tmdbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tmdbId');
    });
  }

  QueryBuilder<SeriesEntity, int, QQueryOperations> tvdbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tvdbId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SeriesImageEntitySchema = Schema(
  name: r'SeriesImageEntity',
  id: 7658543191132481509,
  properties: {
    r'coverType': PropertySchema(
      id: 0,
      name: r'coverType',
      type: IsarType.string,
    ),
    r'remoteUrl': PropertySchema(
      id: 1,
      name: r'remoteUrl',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 2,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _seriesImageEntityEstimateSize,
  serialize: _seriesImageEntitySerialize,
  deserialize: _seriesImageEntityDeserialize,
  deserializeProp: _seriesImageEntityDeserializeProp,
);

int _seriesImageEntityEstimateSize(
  SeriesImageEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.coverType.length * 3;
  {
    final value = object.remoteUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _seriesImageEntitySerialize(
  SeriesImageEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.coverType);
  writer.writeString(offsets[1], object.remoteUrl);
  writer.writeString(offsets[2], object.url);
}

SeriesImageEntity _seriesImageEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SeriesImageEntity();
  object.coverType = reader.readString(offsets[0]);
  object.remoteUrl = reader.readStringOrNull(offsets[1]);
  object.url = reader.readString(offsets[2]);
  return object;
}

P _seriesImageEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SeriesImageEntityQueryFilter
    on QueryBuilder<SeriesImageEntity, SeriesImageEntity, QFilterCondition> {
  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverType',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      coverTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverType',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteUrl',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteUrl',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      remoteUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesImageEntity, SeriesImageEntity, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension SeriesImageEntityQueryObject
    on QueryBuilder<SeriesImageEntity, SeriesImageEntity, QFilterCondition> {}
