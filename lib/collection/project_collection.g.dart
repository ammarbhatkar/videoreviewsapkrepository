// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProjectCollecitonCollection on Isar {
  IsarCollection<ProjectColleciton> get projectCollecitons => this.collection();
}

const ProjectCollecitonSchema = CollectionSchema(
  name: r'ProjectColleciton',
  id: -7355966995390143703,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 1,
      name: r'title',
      type: IsarType.string,
    ),
    r'videopath': PropertySchema(
      id: 2,
      name: r'videopath',
      type: IsarType.string,
    )
  },
  estimateSize: _projectCollecitonEstimateSize,
  serialize: _projectCollecitonSerialize,
  deserialize: _projectCollecitonDeserialize,
  deserializeProp: _projectCollecitonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'markerCollectionObject': LinkSchema(
      id: -8342606299453517028,
      name: r'markerCollectionObject',
      target: r'MarkerCollection',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _projectCollecitonGetId,
  getLinks: _projectCollecitonGetLinks,
  attach: _projectCollecitonAttach,
  version: '3.1.0+1',
);

int _projectCollecitonEstimateSize(
  ProjectColleciton object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.date;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.videopath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _projectCollecitonSerialize(
  ProjectColleciton object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.date);
  writer.writeString(offsets[1], object.title);
  writer.writeString(offsets[2], object.videopath);
}

ProjectColleciton _projectCollecitonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProjectColleciton();
  object.date = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.title = reader.readStringOrNull(offsets[1]);
  object.videopath = reader.readStringOrNull(offsets[2]);
  return object;
}

P _projectCollecitonDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _projectCollecitonGetId(ProjectColleciton object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _projectCollecitonGetLinks(
    ProjectColleciton object) {
  return [object.markerCollectionObject];
}

void _projectCollecitonAttach(
    IsarCollection<dynamic> col, Id id, ProjectColleciton object) {
  object.id = id;
  object.markerCollectionObject.attach(col,
      col.isar.collection<MarkerCollection>(), r'markerCollectionObject', id);
}

extension ProjectCollecitonQueryWhereSort
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QWhere> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProjectCollecitonQueryWhere
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QWhereClause> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterWhereClause>
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterWhereClause>
      idBetween(
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

extension ProjectCollecitonQueryFilter
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QFilterCondition> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleLessThan(
    String? value, {
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
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

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'videopath',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'videopath',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'videopath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'videopath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'videopath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'videopath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'videopath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'videopath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'videopath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'videopath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'videopath',
        value: '',
      ));
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      videopathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'videopath',
        value: '',
      ));
    });
  }
}

extension ProjectCollecitonQueryObject
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QFilterCondition> {}

extension ProjectCollecitonQueryLinks
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QFilterCondition> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObject(FilterQuery<MarkerCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'markerCollectionObject');
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObjectLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'markerCollectionObject', length, true, length, true);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'markerCollectionObject', 0, true, 0, true);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'markerCollectionObject', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObjectLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'markerCollectionObject', 0, true, length, include);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObjectLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'markerCollectionObject', length, include, 999999, true);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterFilterCondition>
      markerCollectionObjectLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'markerCollectionObject', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ProjectCollecitonQuerySortBy
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QSortBy> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      sortByVideopath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videopath', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      sortByVideopathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videopath', Sort.desc);
    });
  }
}

extension ProjectCollecitonQuerySortThenBy
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QSortThenBy> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByVideopath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videopath', Sort.asc);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QAfterSortBy>
      thenByVideopathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videopath', Sort.desc);
    });
  }
}

extension ProjectCollecitonQueryWhereDistinct
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QDistinct> {
  QueryBuilder<ProjectColleciton, ProjectColleciton, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProjectColleciton, ProjectColleciton, QDistinct>
      distinctByVideopath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'videopath', caseSensitive: caseSensitive);
    });
  }
}

extension ProjectCollecitonQueryProperty
    on QueryBuilder<ProjectColleciton, ProjectColleciton, QQueryProperty> {
  QueryBuilder<ProjectColleciton, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProjectColleciton, String?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ProjectColleciton, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ProjectColleciton, String?, QQueryOperations>
      videopathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'videopath');
    });
  }
}
