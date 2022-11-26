import 'dart:convert';

import 'package:domo/components/view_condition.dart';
import 'package:domo/isar/collections/notes_collection.dart';
import 'package:domo/isar/collections/tags_collection.dart';
import 'package:domo/models/note.dart';
import 'package:domo/models/notes_group.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/utils.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:isar/isar.dart';

abstract class SubService {}

typedef NoteFilterQuery
    = QueryBuilder<NoteCollectionItem, NoteCollectionItem, QFilterCondition>;

typedef NoteFilterWhere
    = QueryBuilder<NoteCollectionItem, NoteCollectionItem, QWhere>;

class NotesSubService extends SubService {
  NotesSubService({required this.isar});

  final Isar isar;

  NoteModel _mapNote(NoteCollectionItem note) {
    return NoteModel(
        quillDelta: Delta.fromJson(jsonDecode(note.quillDataJson)),
        uuid: note.uuid,
        filesCount: note.filesCount,
        isImportant: note.isImportant,
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        tags: note.tags
            .map((tag) => TagModel(title: tag.title, uuid: tag.uuid))
            .toList());
  }

  List<NoteModel> _mapNotes(List<NoteCollectionItem> notes) {
    return notes.map((NoteCollectionItem note) => _mapNote(note)).toList();
  }

  NoteFilterQuery _filterByViewCondition(
      NoteFilterQuery query, ViewCondition vCond) {
    NoteFilterQuery newQuery = query;

    final uuid = vCond.tagUUID;
    if (uuid != null) {
      newQuery = newQuery.tags((q) => q.uuidEqualTo(uuid));
    }
    final isImportant = vCond.isImportant;
    if (isImportant != null) {
      newQuery = newQuery.isImportantEqualTo(isImportant);
    }

    return newQuery;
  }

  Future<NoteModel?> getByUuid(String byUuid) async {
    NoteCollectionItem? note =
        await isar.collection<NoteCollectionItem>().getByUuid(byUuid);
    if (note == null) {
      return null;
    }
    return _mapNote(note);
  }

  Future<void> putNote(NoteModel noteModel) async {
    await isar.writeTxn(() async {
      final note = NoteCollectionItem()
        ..uuid = noteModel.uuid
        ..quillDataJson = jsonEncode(noteModel.quillDelta.toJson())
        ..isImportant = noteModel.isImportant
        ..filesCount = 0
        ..createdAt = noteModel.createdAt
        ..updatedAt = noteModel.updatedAt;

      await isar.collection<NoteCollectionItem>().put(note);
      if (noteModel.tags.isNotEmpty) {
        final noteTags = await isar
            .collection<TagsCollectionItem>()
            .filter()
            .anyOf(noteModel.tags.map((t) => t.uuid),
                (q, element) => q.uuidEqualTo(element))
            .findAll();

        for (TagsCollectionItem tag in noteTags) {
          note.tags.add(tag);
        }
        await note.tags.save();
      }
    });
  }

  Future<List<NoteModel>> getNotesByDate(
      {required DateTime byDate, ViewCondition? vCond}) async {
    DateTime startDate = DateTime(byDate.year, byDate.month, byDate.day);
    DateTime endDate = DateTime(byDate.year, byDate.month, byDate.day + 1);

    NoteFilterQuery query = isar.collection<NoteCollectionItem>().filter();

    if (vCond != null) {
      query = _filterByViewCondition(query, vCond);
    }

    List<NoteCollectionItem> notes = await query
        .createdAtBetween(startDate, endDate)
        .sortByCreatedAtDesc()
        .findAll();

    return _mapNotes(notes);
  }

  Future<List<NoteModel>> getNotesByDateRange(
      {required DateTime lower,
      required DateTime upper,
      ViewCondition? vCond}) async {
    NoteFilterQuery query = isar.collection<NoteCollectionItem>().filter();

    if (vCond != null) {
      query = _filterByViewCondition(query, vCond);
    }

    List<NoteCollectionItem> notes = await query
        .group(
            (q) => q.createdAtGreaterThan(lower).or().createdAtEqualTo(lower))
        .createdAtLessThan(upper)
        .sortByCreatedAtDesc()
        .findAll();

    return _mapNotes(notes);
  }

  Future<int> getNotesCountByDate(
      {required DateTime dt, ViewCondition? vCond}) async {
    DateTime startDate = DateTime(dt.year, dt.month, dt.day);
    DateTime endDate = DateTime(dt.year, dt.month, dt.day + 1);

    NoteFilterQuery query = isar.collection<NoteCollectionItem>().filter();

    if (vCond != null) {
      query = _filterByViewCondition(query, vCond);
    }

    int notesCount = await query.createdAtBetween(startDate, endDate).count();

    return notesCount;
  }

  Future<List<DateTime>> getNoteDatesLte(
      {required DateTime fromDate,
      int amount = 7,
      ViewCondition? vCond}) async {
    List<DateTime> dates = [];

    NoteFilterQuery query = isar.collection<NoteCollectionItem>().filter();

    if (vCond != null) {
      query = _filterByViewCondition(query, vCond);
    }

    DateTime dt = fromDate;

    for (int i = 0; i < amount; i++) {
      final maxDate = await query
          .group((q) => q.createdAtLessThan(dt).or().createdAtEqualTo(dt))
          .createdAtProperty()
          .max();

      if (maxDate != null) {
        dates.add(maxDate);
        dt = maxDate.add(const Duration(days: -1));
      }
    }
    return dates;
  }

  Future<NotesGroupModel> getNotesDayGroupByDate(
      {required DateTime byDate, int amount = 7, ViewCondition? vCond}) async {
    // Getting all notes by date
    List<NoteModel> notes = await getNotesByDate(byDate: byDate, vCond: vCond);

    return NotesGroupModel(
        groupKey: ViewGroupKey.dayGroupKeyByDate(byDate), items: notes);
  }
}

class TagsSubService extends SubService {
  TagsSubService({required this.isar});

  final Isar isar;

  TagModel _map(TagsCollectionItem tag) {
    return TagModel(title: tag.title, uuid: tag.uuid);
  }

  List<TagModel> _mapList(List<TagsCollectionItem> tags) {
    return tags.map<TagModel>((TagsCollectionItem x) => _map(x)).toList();
  }

  Future<List<TagModel>> getAll() async {
    final tags = await isar
        .collection<TagsCollectionItem>()
        .where()
        .sortByCreatedAtDesc()
        .findAll();
    return _mapList(tags);
  }

  Future<void> put(TagModel tagModel) async {
    await isar.writeTxn(() async {

      TagsCollectionItem? tag = await isar.tagsCollectionItems.getByUuid(tagModel.uuid);

      if(tag == null) {
        tag = TagsCollectionItem()
          ..uuid = tagModel.uuid
          ..title = tagModel.title
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();
      } else {
        tag.title = tagModel.title;
        tag.updatedAt = DateTime.now();
      }

      await isar.collection<TagsCollectionItem>().put(tag);
    });
  }

  Future<void> remove(TagModel tagModel) async {
    await isar.writeTxn(() async {
      await isar.collection<TagsCollectionItem>().deleteByUuid(tagModel.uuid);
    });
  }
}

class DbService {
  final Isar isar;
  late NotesSubService notes;
  late TagsSubService tags;

  DbService({required this.isar}) {
    notes = NotesSubService(isar: isar);
    tags = TagsSubService(isar: isar);
  }
}
