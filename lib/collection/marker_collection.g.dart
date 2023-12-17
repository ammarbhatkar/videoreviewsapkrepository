// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMarkerCollectionCollection on Isar {
  IsarCollection<MarkerCollection> get markerCollections => this.collection();
}

const MarkerCollectionSchema = CollectionSchema(
  name: r'MarkerCollection',
  id: -5587611402620590330,
  properties: {
    r'dx': PropertySchema(
      id: 0,
      name: r'dx',
      type: IsarType.double,
    ),
    r'dy': PropertySchema(
      id: 1,
      name: r'dy',
      type: IsarType.double,
    ),
    r'feedback': PropertySchema(
      id: 2,
      name: r'feedback',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 3,
      name: r'order',
      type: IsarType.long,
    ),
    r'projectId': PropertySchema(
      id: 4,
      name: r'projectId',
      type: IsarType.long,
    ),
    r'timeStamp': PropertySchema(
      id: 5,
      name: r'timeStamp',
      type: IsarType.long,
    )
  },
  estimateSize: _markerCollectionEstimateSize,
  serialize: _markerCollectionSerialize,
  deserialize: _markerCollectionDeserialize,
  deserializeProp: _markerCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _markerCollectionGetId,
  getLinks: _markerCollectionGetLinks,
  attach: _markerCollectionAttach,
  version: '3.1.0+1',
);

int _markerCollectionEstimateSize(
  MarkerCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.feedback;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _markerCollectionSerialize(
  MarkerCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.dx);
  writer.writeDouble(offsets[1], object.dy);
  writer.writeString(offsets[2], object.feedback);
  writer.writeLong(offsets[3], object.order);
  writer.writeLong(offsets[4], object.projectId);
  writer.writeLong(offsets[5], object.timeStamp);
}

MarkerCollection _markerCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MarkerCollection();
  object.dx = reader.readDoubleOrNull(offsets[0]);
  object.dy = reader.readDoubleOrNull(offsets[1]);
  object.feedback = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.order = reader.readLongOrNull(offsets[3]);
  object.projectId = reader.readLongOrNull(offsets[4]);
  object.timeStamp = reader.readLongOrNull(offsets[5]);
  return object;
}

P _markerCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _markerCollectionGetId(MarkerCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _markerCollectionGetLinks(MarkerCollection object) {
  return [];
}

void _markerCollectionAttach(
    IsarCollection<dynamic> col, Id id, MarkerCollection object) {
  object.id = id;
}

extension MarkerCollectionQueryWhereSort
    on QueryBuilder<MarkerCollection, MarkerCollection, QWhere> {
  QueryBuilder<MarkerCollection, MarkerCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MarkerCollectionQueryWhere
    on QueryBuilder<MarkerCollection, MarkerCollection, QWhereClause> {
  QueryBuilder<MarkerCollection, MarkerCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterWhereClause>
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

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterWhereClause> idBetween(
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
}

extension MarkerCollectionQueryFilter
    on QueryBuilder<MarkerCollection, MarkerCollection, QFilterCondition> {
  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dx',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dx',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dxEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dx',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dxGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dx',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dxLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dx',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dxBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dx',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dy',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dy',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dyEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dyGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dyLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      dyBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'feedback',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'feedback',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedback',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'feedback',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedback',
        value: '',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      feedbackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'feedback',
        value: '',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
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

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
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

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
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

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      orderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      orderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      orderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      orderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      orderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      orderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      projectIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'projectId',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      projectIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'projectId',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      projectIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'projectId',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      projectIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'projectId',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      projectIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'projectId',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      projectIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'projectId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      timeStampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeStamp',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      timeStampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeStamp',
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      timeStampEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      timeStampGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      timeStampLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterFilterCondition>
      timeStampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeStamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MarkerCollectionQueryObject
    on QueryBuilder<MarkerCollection, MarkerCollection, QFilterCondition> {}

extension MarkerCollectionQueryLinks
    on QueryBuilder<MarkerCollection, MarkerCollection, QFilterCondition> {}

extension MarkerCollectionQuerySortBy
    on QueryBuilder<MarkerCollection, MarkerCollection, QSortBy> {
  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> sortByDx() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByDxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> sortByDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByDyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByProjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByProjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      sortByTimeStampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.desc);
    });
  }
}

extension MarkerCollectionQuerySortThenBy
    on QueryBuilder<MarkerCollection, MarkerCollection, QSortThenBy> {
  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> thenByDx() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByDxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dx', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> thenByDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByDyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dy', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByProjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByProjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.desc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.asc);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QAfterSortBy>
      thenByTimeStampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.desc);
    });
  }
}

extension MarkerCollectionQueryWhereDistinct
    on QueryBuilder<MarkerCollection, MarkerCollection, QDistinct> {
  QueryBuilder<MarkerCollection, MarkerCollection, QDistinct> distinctByDx() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dx');
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QDistinct> distinctByDy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dy');
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QDistinct>
      distinctByFeedback({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'feedback', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QDistinct>
      distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QDistinct>
      distinctByProjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'projectId');
    });
  }

  QueryBuilder<MarkerCollection, MarkerCollection, QDistinct>
      distinctByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeStamp');
    });
  }
}

extension MarkerCollectionQueryProperty
    on QueryBuilder<MarkerCollection, MarkerCollection, QQueryProperty> {
  QueryBuilder<MarkerCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MarkerCollection, double?, QQueryOperations> dxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dx');
    });
  }

  QueryBuilder<MarkerCollection, double?, QQueryOperations> dyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dy');
    });
  }

  QueryBuilder<MarkerCollection, String?, QQueryOperations> feedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'feedback');
    });
  }

  QueryBuilder<MarkerCollection, int?, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<MarkerCollection, int?, QQueryOperations> projectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'projectId');
    });
  }

  QueryBuilder<MarkerCollection, int?, QQueryOperations> timeStampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeStamp');
    });
  }
}
