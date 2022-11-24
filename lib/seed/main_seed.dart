import 'dart:convert';
import 'dart:math';

import 'package:domo/fake/fake_factories.dart';
import 'package:domo/isar/collections/date_index_collection.dart';
import 'package:domo/isar/collections/notes_collection.dart';
import 'package:domo/isar/collections/tags_collection.dart';
import 'package:domo/models/note.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/services/db_service.dart';
import 'package:isar/isar.dart';

Future<void> mainSeed(Isar isar) async {
  List<TagModel> tags = [];
  FakeTagFactory tagsFactory = FakeTagFactory();
  for (int i = 0; i < tagsFactory.labelNames.length; i++) {
    tags.add(tagsFactory.fake());
  }

  await isar.writeTxn(() async {
    await isar.collection<TagsCollectionItem>().clear();
  });


  await isar.writeTxn(() async {
    for (TagModel tagModel in tags) {
      final tag = TagsCollectionItem()
        ..uuid = tagModel.uuid
        ..title = tagModel.title
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
      await isar.collection<TagsCollectionItem>().put(tag);
    }
  });

  FakeCalendarViewFactory cvFactory = FakeCalendarViewFactory();

  DateTime dt = DateTime.now();
  List<NoteModel> noteModels = [];
  List<DateTime> noteDates = [];

  for (int i = 0; i < 100; i++) {
    noteDates.add(dt);
    int itemsAmount = Random().nextInt(7) + 1;
    for (int i = 0; i < itemsAmount; i++) {
      noteModels.add(cvFactory.fakeItem(
          createdAt: dt.add(Duration(minutes: Random().nextInt(30))),
          updatedAt: dt.add(Duration(minutes: Random().nextInt(30) + 30)),
          tags: tags.sublist(0, Random().nextInt(tags.length))));
    }
    dt = dt.add(Duration(days: -Random().nextInt(3)));
  }

  await isar.writeTxn(() async {
    await isar.collection<NoteCollectionItem>().clear();
  });

  await isar.writeTxn(() async {
    for (NoteModel noteModel in noteModels) {
      final note = NoteCollectionItem()
        ..uuid = noteModel.uuid
        ..quillDataJson = jsonEncode(noteModel.quillDelta.toJson())
        ..filesCount = 0
        ..createdAt = noteModel.createdAt
        ..updatedAt = noteModel.updatedAt
        ..tags = noteModel.tags
            .map<TagEmbedded>((TagModel tm) => TagEmbedded()
          ..uuid = tm.uuid
          ..title = tm.title)
            .toList();

      await isar.collection<NoteCollectionItem>().put(note);
    }
  });

  await isar.writeTxn(() async {
    await isar.collection<DateIndexCollectionItem>().clear();
  });

  DbService dbService = DbService(isar: isar);

  await isar.writeTxn(() async {
    for (DateTime noteDate in noteDates) {
      int notesCount = await dbService.notes.getNotesCountByDate(dt: noteDate);
      final dateIndex = DateIndexCollectionItem()
        ..date = noteDate
        ..count = notesCount;
      await isar.collection<DateIndexCollectionItem>().put(dateIndex);
    }
  });

}
