// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMovieEntityCollection on Isar {
  IsarCollection<MovieEntity> get movieEntitys => this.collection();
}

const MovieEntitySchema = CollectionSchema(
  name: r'MovieEntity',
  id: -7056872361443638649,
  properties: {
    r'hasFile': PropertySchema(
      id: 0,
      name: r'hasFile',
      type: IsarType.bool,
    ),
    r'images': PropertySchema(
      id: 1,
      name: r'images',
      type: IsarType.objectList,
      target: r'MovieImageEntity',
    ),
    r'overview': PropertySchema(
      id: 2,
      name: r'overview',
      type: IsarType.string,
    ),
    r'radarrId': PropertySchema(
      id: 3,
      name: r'radarrId',
      type: IsarType.long,
    ),
    r'remotePath': PropertySchema(
      id: 4,
      name: r'remotePath',
      type: IsarType.string,
    ),
    r'sizeOnDisk': PropertySchema(
      id: 5,
      name: r'sizeOnDisk',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 6,
      name: r'title',
      type: IsarType.string,
    ),
    r'tmdbId': PropertySchema(
      id: 7,
      name: r'tmdbId',
      type: IsarType.long,
    )
  },
  estimateSize: _movieEntityEstimateSize,
  serialize: _movieEntitySerialize,
  deserialize: _movieEntityDeserialize,
  deserializeProp: _movieEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'radarrId': IndexSchema(
      id: -884141415761302937,
      name: r'radarrId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'radarrId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'MovieImageEntity': MovieImageEntitySchema},
  getId: _movieEntityGetId,
  getLinks: _movieEntityGetLinks,
  attach: _movieEntityAttach,
  version: '3.1.0+1',
);

int _movieEntityEstimateSize(
  MovieEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.images.length * 3;
  {
    final offsets = allOffsets[MovieImageEntity]!;
    for (var i = 0; i < object.images.length; i++) {
      final value = object.images[i];
      bytesCount +=
          MovieImageEntitySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.overview.length * 3;
  {
    final value = object.remotePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _movieEntitySerialize(
  MovieEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.hasFile);
  writer.writeObjectList<MovieImageEntity>(
    offsets[1],
    allOffsets,
    MovieImageEntitySchema.serialize,
    object.images,
  );
  writer.writeString(offsets[2], object.overview);
  writer.writeLong(offsets[3], object.radarrId);
  writer.writeString(offsets[4], object.remotePath);
  writer.writeLong(offsets[5], object.sizeOnDisk);
  writer.writeString(offsets[6], object.title);
  writer.writeLong(offsets[7], object.tmdbId);
}

MovieEntity _movieEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MovieEntity();
  object.hasFile = reader.readBool(offsets[0]);
  object.id = id;
  object.images = reader.readObjectList<MovieImageEntity>(
        offsets[1],
        MovieImageEntitySchema.deserialize,
        allOffsets,
        MovieImageEntity(),
      ) ??
      [];
  object.overview = reader.readString(offsets[2]);
  object.radarrId = reader.readLong(offsets[3]);
  object.remotePath = reader.readStringOrNull(offsets[4]);
  object.sizeOnDisk = reader.readLong(offsets[5]);
  object.title = reader.readString(offsets[6]);
  object.tmdbId = reader.readLongOrNull(offsets[7]);
  return object;
}

P _movieEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readObjectList<MovieImageEntity>(
            offset,
            MovieImageEntitySchema.deserialize,
            allOffsets,
            MovieImageEntity(),
          ) ??
          []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _movieEntityGetId(MovieEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _movieEntityGetLinks(MovieEntity object) {
  return [];
}

void _movieEntityAttach(
    IsarCollection<dynamic> col, Id id, MovieEntity object) {
  object.id = id;
}

extension MovieEntityByIndex on IsarCollection<MovieEntity> {
  Future<MovieEntity?> getByRadarrId(int radarrId) {
    return getByIndex(r'radarrId', [radarrId]);
  }

  MovieEntity? getByRadarrIdSync(int radarrId) {
    return getByIndexSync(r'radarrId', [radarrId]);
  }

  Future<bool> deleteByRadarrId(int radarrId) {
    return deleteByIndex(r'radarrId', [radarrId]);
  }

  bool deleteByRadarrIdSync(int radarrId) {
    return deleteByIndexSync(r'radarrId', [radarrId]);
  }

  Future<List<MovieEntity?>> getAllByRadarrId(List<int> radarrIdValues) {
    final values = radarrIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'radarrId', values);
  }

  List<MovieEntity?> getAllByRadarrIdSync(List<int> radarrIdValues) {
    final values = radarrIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'radarrId', values);
  }

  Future<int> deleteAllByRadarrId(List<int> radarrIdValues) {
    final values = radarrIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'radarrId', values);
  }

  int deleteAllByRadarrIdSync(List<int> radarrIdValues) {
    final values = radarrIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'radarrId', values);
  }

  Future<Id> putByRadarrId(MovieEntity object) {
    return putByIndex(r'radarrId', object);
  }

  Id putByRadarrIdSync(MovieEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'radarrId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRadarrId(List<MovieEntity> objects) {
    return putAllByIndex(r'radarrId', objects);
  }

  List<Id> putAllByRadarrIdSync(List<MovieEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'radarrId', objects, saveLinks: saveLinks);
  }
}

extension MovieEntityQueryWhereSort
    on QueryBuilder<MovieEntity, MovieEntity, QWhere> {
  QueryBuilder<MovieEntity, MovieEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhere> anyRadarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'radarrId'),
      );
    });
  }
}

extension MovieEntityQueryWhere
    on QueryBuilder<MovieEntity, MovieEntity, QWhereClause> {
  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> radarrIdEqualTo(
      int radarrId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'radarrId',
        value: [radarrId],
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> radarrIdNotEqualTo(
      int radarrId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'radarrId',
              lower: [],
              upper: [radarrId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'radarrId',
              lower: [radarrId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'radarrId',
              lower: [radarrId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'radarrId',
              lower: [],
              upper: [radarrId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> radarrIdGreaterThan(
    int radarrId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'radarrId',
        lower: [radarrId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> radarrIdLessThan(
    int radarrId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'radarrId',
        lower: [],
        upper: [radarrId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterWhereClause> radarrIdBetween(
    int lowerRadarrId,
    int upperRadarrId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'radarrId',
        lower: [lowerRadarrId],
        includeLower: includeLower,
        upper: [upperRadarrId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MovieEntityQueryFilter
    on QueryBuilder<MovieEntity, MovieEntity, QFilterCondition> {
  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> hasFileEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasFile',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> overviewEqualTo(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> overviewBetween(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      overviewContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'overview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> overviewMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'overview',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      overviewIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overview',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      overviewIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'overview',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> radarrIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'radarrId',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      radarrIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'radarrId',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      radarrIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'radarrId',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> radarrIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'radarrId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remotePath',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remotePath',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remotePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remotePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remotePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remotePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remotePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remotePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remotePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remotePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remotePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      remotePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remotePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      sizeOnDiskEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sizeOnDisk',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      sizeOnDiskGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sizeOnDisk',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      sizeOnDiskLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sizeOnDisk',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      sizeOnDiskBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sizeOnDisk',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleContains(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleMatches(
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> tmdbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tmdbId',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      tmdbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tmdbId',
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> tmdbIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tmdbId',
        value: value,
      ));
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition>
      tmdbIdGreaterThan(
    int? value, {
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> tmdbIdLessThan(
    int? value, {
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

  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> tmdbIdBetween(
    int? lower,
    int? upper, {
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
}

extension MovieEntityQueryObject
    on QueryBuilder<MovieEntity, MovieEntity, QFilterCondition> {
  QueryBuilder<MovieEntity, MovieEntity, QAfterFilterCondition> imagesElement(
      FilterQuery<MovieImageEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'images');
    });
  }
}

extension MovieEntityQueryLinks
    on QueryBuilder<MovieEntity, MovieEntity, QFilterCondition> {}

extension MovieEntityQuerySortBy
    on QueryBuilder<MovieEntity, MovieEntity, QSortBy> {
  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByHasFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFile', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByHasFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFile', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByOverview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByOverviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByRadarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radarrId', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByRadarrIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radarrId', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByRemotePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePath', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByRemotePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePath', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortBySizeOnDisk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeOnDisk', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortBySizeOnDiskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeOnDisk', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByTmdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> sortByTmdbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.desc);
    });
  }
}

extension MovieEntityQuerySortThenBy
    on QueryBuilder<MovieEntity, MovieEntity, QSortThenBy> {
  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByHasFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFile', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByHasFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFile', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByOverview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByOverviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByRadarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radarrId', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByRadarrIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radarrId', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByRemotePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePath', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByRemotePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePath', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenBySizeOnDisk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeOnDisk', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenBySizeOnDiskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeOnDisk', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByTmdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.asc);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QAfterSortBy> thenByTmdbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmdbId', Sort.desc);
    });
  }
}

extension MovieEntityQueryWhereDistinct
    on QueryBuilder<MovieEntity, MovieEntity, QDistinct> {
  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctByHasFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasFile');
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctByOverview(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overview', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctByRadarrId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'radarrId');
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctByRemotePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remotePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctBySizeOnDisk() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sizeOnDisk');
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovieEntity, MovieEntity, QDistinct> distinctByTmdbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tmdbId');
    });
  }
}

extension MovieEntityQueryProperty
    on QueryBuilder<MovieEntity, MovieEntity, QQueryProperty> {
  QueryBuilder<MovieEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MovieEntity, bool, QQueryOperations> hasFileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasFile');
    });
  }

  QueryBuilder<MovieEntity, List<MovieImageEntity>, QQueryOperations>
      imagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'images');
    });
  }

  QueryBuilder<MovieEntity, String, QQueryOperations> overviewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overview');
    });
  }

  QueryBuilder<MovieEntity, int, QQueryOperations> radarrIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'radarrId');
    });
  }

  QueryBuilder<MovieEntity, String?, QQueryOperations> remotePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remotePath');
    });
  }

  QueryBuilder<MovieEntity, int, QQueryOperations> sizeOnDiskProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sizeOnDisk');
    });
  }

  QueryBuilder<MovieEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<MovieEntity, int?, QQueryOperations> tmdbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tmdbId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MovieImageEntitySchema = Schema(
  name: r'MovieImageEntity',
  id: -6575743608490660974,
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
  estimateSize: _movieImageEntityEstimateSize,
  serialize: _movieImageEntitySerialize,
  deserialize: _movieImageEntityDeserialize,
  deserializeProp: _movieImageEntityDeserializeProp,
);

int _movieImageEntityEstimateSize(
  MovieImageEntity object,
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

void _movieImageEntitySerialize(
  MovieImageEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.coverType);
  writer.writeString(offsets[1], object.remoteUrl);
  writer.writeString(offsets[2], object.url);
}

MovieImageEntity _movieImageEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MovieImageEntity();
  object.coverType = reader.readString(offsets[0]);
  object.remoteUrl = reader.readStringOrNull(offsets[1]);
  object.url = reader.readString(offsets[2]);
  return object;
}

P _movieImageEntityDeserializeProp<P>(
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

extension MovieImageEntityQueryFilter
    on QueryBuilder<MovieImageEntity, MovieImageEntity, QFilterCondition> {
  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      coverTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      coverTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      coverTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverType',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      coverTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverType',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      remoteUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteUrl',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      remoteUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteUrl',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      remoteUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      remoteUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      remoteUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      remoteUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
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

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<MovieImageEntity, MovieImageEntity, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension MovieImageEntityQueryObject
    on QueryBuilder<MovieImageEntity, MovieImageEntity, QFilterCondition> {}
