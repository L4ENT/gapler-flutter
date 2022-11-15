// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetNoteCollectionItemCollection on Isar {
  IsarCollection<NoteCollectionItem> get noteCollectionItems =>
      this.collection();
}

const NoteCollectionItemSchema = CollectionSchema(
  name: r'notes',
  id: 8092016287011465773,
  properties: {
    r'created_at': PropertySchema(
      id: 0,
      name: r'created_at',
      type: IsarType.dateTime,
    ),
    r'files_count': PropertySchema(
      id: 1,
      name: r'files_count',
      type: IsarType.long,
    ),
    r'is_important': PropertySchema(
      id: 2,
      name: r'is_important',
      type: IsarType.bool,
    ),
    r'quill_data_json': PropertySchema(
      id: 3,
      name: r'quill_data_json',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 4,
      name: r'tags',
      type: IsarType.objectList,
      target: r'TagEmbedded',
    ),
    r'updated_at': PropertySchema(
      id: 5,
      name: r'updated_at',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _noteCollectionItemEstimateSize,
  serialize: _noteCollectionItemSerialize,
  deserialize: _noteCollectionItemDeserialize,
  deserializeProp: _noteCollectionItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'TagEmbedded': TagEmbeddedSchema},
  getId: _noteCollectionItemGetId,
  getLinks: _noteCollectionItemGetLinks,
  attach: _noteCollectionItemAttach,
  version: '3.0.4',
);

int _noteCollectionItemEstimateSize(
  NoteCollectionItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.quillDataJson.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    final offsets = allOffsets[TagEmbedded]!;
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += TagEmbeddedSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _noteCollectionItemSerialize(
  NoteCollectionItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.filesCount);
  writer.writeBool(offsets[2], object.isImportant);
  writer.writeString(offsets[3], object.quillDataJson);
  writer.writeObjectList<TagEmbedded>(
    offsets[4],
    allOffsets,
    TagEmbeddedSchema.serialize,
    object.tags,
  );
  writer.writeDateTime(offsets[5], object.updatedAt);
  writer.writeString(offsets[6], object.uuid);
}

NoteCollectionItem _noteCollectionItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NoteCollectionItem();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.filesCount = reader.readLong(offsets[1]);
  object.id = id;
  object.isImportant = reader.readBool(offsets[2]);
  object.quillDataJson = reader.readString(offsets[3]);
  object.tags = reader.readObjectList<TagEmbedded>(
        offsets[4],
        TagEmbeddedSchema.deserialize,
        allOffsets,
        TagEmbedded(),
      ) ??
      [];
  object.updatedAt = reader.readDateTime(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _noteCollectionItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readObjectList<TagEmbedded>(
            offset,
            TagEmbeddedSchema.deserialize,
            allOffsets,
            TagEmbedded(),
          ) ??
          []) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _noteCollectionItemGetId(NoteCollectionItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _noteCollectionItemGetLinks(
    NoteCollectionItem object) {
  return [];
}

void _noteCollectionItemAttach(
    IsarCollection<dynamic> col, Id id, NoteCollectionItem object) {
  object.id = id;
}

extension NoteCollectionItemByIndex on IsarCollection<NoteCollectionItem> {
  Future<NoteCollectionItem?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  NoteCollectionItem? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<NoteCollectionItem?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<NoteCollectionItem?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(NoteCollectionItem object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(NoteCollectionItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<NoteCollectionItem> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<NoteCollectionItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension NoteCollectionItemQueryWhereSort
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QWhere> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NoteCollectionItemQueryWhere
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QWhereClause> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
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

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
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

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension NoteCollectionItemQueryFilter
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QFilterCondition> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created_at',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created_at',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created_at',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created_at',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      filesCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'files_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      filesCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'files_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      filesCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'files_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      filesCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'files_count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
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

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
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

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
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

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      isImportantEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'is_important',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quill_data_json',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quill_data_json',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quill_data_json',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quill_data_json',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quill_data_json',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quill_data_json',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quill_data_json',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quill_data_json',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quill_data_json',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      quillDataJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quill_data_json',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updated_at',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updated_at',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updated_at',
        value: value,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updated_at',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension NoteCollectionItemQueryObject
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QFilterCondition> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterFilterCondition>
      tagsElement(FilterQuery<TagEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tags');
    });
  }
}

extension NoteCollectionItemQueryLinks
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QFilterCondition> {}

extension NoteCollectionItemQuerySortBy
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QSortBy> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByFilesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'files_count', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByFilesCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'files_count', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByIsImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_important', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByIsImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_important', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByQuillDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quill_data_json', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByQuillDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quill_data_json', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated_at', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated_at', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension NoteCollectionItemQuerySortThenBy
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QSortThenBy> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_at', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByFilesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'files_count', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByFilesCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'files_count', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByIsImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_important', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByIsImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_important', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByQuillDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quill_data_json', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByQuillDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quill_data_json', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated_at', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updated_at', Sort.desc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension NoteCollectionItemQueryWhereDistinct
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct> {
  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created_at');
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct>
      distinctByFilesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'files_count');
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct>
      distinctByIsImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'is_important');
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct>
      distinctByQuillDataJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quill_data_json',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updated_at');
    });
  }

  QueryBuilder<NoteCollectionItem, NoteCollectionItem, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension NoteCollectionItemQueryProperty
    on QueryBuilder<NoteCollectionItem, NoteCollectionItem, QQueryProperty> {
  QueryBuilder<NoteCollectionItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NoteCollectionItem, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created_at');
    });
  }

  QueryBuilder<NoteCollectionItem, int, QQueryOperations> filesCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'files_count');
    });
  }

  QueryBuilder<NoteCollectionItem, bool, QQueryOperations>
      isImportantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'is_important');
    });
  }

  QueryBuilder<NoteCollectionItem, String, QQueryOperations>
      quillDataJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quill_data_json');
    });
  }

  QueryBuilder<NoteCollectionItem, List<TagEmbedded>, QQueryOperations>
      tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<NoteCollectionItem, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updated_at');
    });
  }

  QueryBuilder<NoteCollectionItem, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const TagEmbeddedSchema = Schema(
  name: r'TagEmbedded',
  id: -8630601123932382683,
  properties: {
    r'title': PropertySchema(
      id: 0,
      name: r'title',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 1,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _tagEmbeddedEstimateSize,
  serialize: _tagEmbeddedSerialize,
  deserialize: _tagEmbeddedDeserialize,
  deserializeProp: _tagEmbeddedDeserializeProp,
);

int _tagEmbeddedEstimateSize(
  TagEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _tagEmbeddedSerialize(
  TagEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.title);
  writer.writeString(offsets[1], object.uuid);
}

TagEmbedded _tagEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TagEmbedded();
  object.title = reader.readString(offsets[0]);
  object.uuid = reader.readString(offsets[1]);
  return object;
}

P _tagEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TagEmbeddedQueryFilter
    on QueryBuilder<TagEmbedded, TagEmbedded, QFilterCondition> {
  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition>
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleContains(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleMatches(
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

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<TagEmbedded, TagEmbedded, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension TagEmbeddedQueryObject
    on QueryBuilder<TagEmbedded, TagEmbedded, QFilterCondition> {}
