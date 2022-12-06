import 'dart:convert';
import 'dart:math';

import 'package:gapler/fake/fake_factories.dart';
import 'package:gapler/isar/collections/date_index_collection.dart';
import 'package:gapler/isar/collections/notes_collection.dart';
import 'package:gapler/isar/collections/tags_collection.dart';
import 'package:gapler/models/note.dart';
import 'package:gapler/models/tag.dart';
import 'package:gapler/services/db_service.dart';
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

Future<void> cleanSeed(Isar isar) async {
  await isar.writeTxn(() async {
    await isar.collection<TagsCollectionItem>().clear();
  });

  await isar.writeTxn(() async {
    await isar.collection<NoteCollectionItem>().clear();
  });

  await isar.writeTxn(() async {
    await isar.collection<DateIndexCollectionItem>().clear();
  });

}