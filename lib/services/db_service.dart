import 'dart:convert';

import 'package:domo/isar/collections/date_index_collection.dart';
import 'package:domo/isar/collections/notes_collection.dart';
import 'package:domo/models/note.dart';
import 'package:domo/models/notes_group.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/utils.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:isar/isar.dart';

abstract class SubService {}

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
    return notes
        .map((NoteCollectionItem note) => _mapNote(note))
        .toList();
  }

  Future<NoteModel?> getByUuid(String byUuid) async {
    NoteCollectionItem? note = await isar.collection<NoteCollectionItem>().getByUuid(byUuid);
    if(note == null){
      return null;
    }
    return _mapNote(note);
  }

  Future<void> putNote(NoteModel noteModel) async{
    await isar.writeTxn(() async {
      final note = NoteCollectionItem()
        ..uuid = noteModel.uuid
        ..quillDataJson = jsonEncode(noteModel.quillDelta.toJson())
        ..isImportant = noteModel.isImportant
        ..filesCount = 0
        ..createdAt = noteModel.createdAt
        ..updatedAt = noteModel.updatedAt
        ..tags = noteModel.tags
            .map<TagEmbedded>((TagModel tm) => TagEmbedded()
          ..uuid = tm.uuid
          ..title = tm.title)
            .toList();

      await isar.collection<NoteCollectionItem>().put(note);
    });
  }

  Future<List<NoteModel>> getNotesByDate({required DateTime byDate}) async {
    DateTime startDate = DateTime(byDate.year, byDate.month, byDate.day);
    DateTime endDate = DateTime(byDate.year, byDate.month, byDate.day + 1);

    List<NoteCollectionItem> notes = await isar
        .collection<NoteCollectionItem>()
        .filter()
        .createdAtBetween(startDate, endDate)
        .sortByCreatedAtDesc()
        .findAll();

    return _mapNotes(notes);
  }

  Future<List<NoteModel>> getNotesByDateRange(
      {required DateTime lower, required DateTime upper}) async {
    List<NoteCollectionItem> notes = await isar
        .collection<NoteCollectionItem>()
        .filter()
        .group(
            (q) => q.createdAtGreaterThan(lower).or().createdAtEqualTo(lower))
        .createdAtLessThan(upper)
        .sortByCreatedAtDesc()
        .findAll();

    return _mapNotes(notes);
  }

  Future<int> getNotesCountByDate({required DateTime dt}) async {
    DateTime startDate = DateTime(dt.year, dt.month, dt.day);
    DateTime endDate = DateTime(dt.year, dt.month, dt.day + 1);

    int notesCount = await isar
        .collection<NoteCollectionItem>()
        .filter()
        .createdAtBetween(startDate, endDate)
        .count();

    return notesCount;
  }

  // Future<List<NotesGroupModel>> getNotesGroupsDaysBatch(
  //     {required DateTime dt, int amount = 7}) async {
  //   final dateCollectionProp = isar
  //       .collection<DateIndexCollectionItem>()
  //       .filter()
  //       .countGreaterThan(0)
  //       .dateLessThan(dt)
  //       .sortByDateDesc()
  //       .limit(amount)
  //       .dateProperty();
  //
  //   final DateTime minDate = await dateCollectionProp.min() ?? DateTime.now();
  //   final DateTime maxDate = await dateCollectionProp.max() ?? DateTime.now();
  //
  //   List<NoteModel> noteModels =
  //       await getNotesByDateRange(lower: minDate, upper: maxDate);
  //
  //   List<NotesGroupModel> groups = [];
  //
  //   DateTime loopDate = maxDate;
  //   List<NoteModel> loopItems = [];
  //
  //   for (NoteModel note in noteModels) {
  //     if (note.createdAt.difference(loopDate).inDays > 0) {
  //       if (loopItems.isNotEmpty) {
  //         final String formatted = getDateOnlyString(loopDate);
  //         groups.add(
  //             NotesGroupModel(groupKey: 'days:$formatted', items: loopItems));
  //       }
  //       loopDate = note.createdAt;
  //       loopItems = [];
  //     }
  //     loopItems.add(note);
  //   }
  //
  //   return groups;
  // }

  Future<List<DateTime>> getNoteDatesLte(
      {required DateTime fromDate, int amount = 7}) async {
    List<DateTime> dates = await isar
        .collection<DateIndexCollectionItem>()
        .filter()
        .countGreaterThan(0)
        .group((q) => q.dateLessThan(fromDate).or().dateEqualTo(fromDate))
        .sortByDateDesc()
        .limit(amount)
        .dateProperty()
        .findAll();
    return dates;
  }

  Future<NotesGroupModel> getNotesDayGroupByDate(
      {required DateTime byDate, int amount = 7}) async {

    // Getting all notes by date
    List<NoteModel> notes = await getNotesByDate(byDate: byDate);

    return NotesGroupModel(
        groupKey: ViewGroupKey.dayGroupKeyByDate(byDate), items: notes);
  }
}

class DbService {
  final Isar isar;
  late NotesSubService notes;

  DbService({required this.isar}) {
    notes = NotesSubService(isar: isar);
  }
}
