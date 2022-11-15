import 'dart:math';

import 'package:domo/models/tag.dart';
import 'package:uuid/uuid.dart';

import 'package:domo/models/note.dart';
import 'package:domo/models/notes_group.dart';

var uuid = const Uuid();

class FakeTagFactory {
  final List<String> labelNames = [
    'Home',
    'Business',
    'Work',
    'Todos',
    'Events'
  ];

  TagModel fake() {
    final today = DateTime.now();
    final createdAt = today.add(Duration(days: Random().nextInt(3)));
    final updatedAt = createdAt.add(Duration(days: Random().nextInt(3)));
    return TagModel(
      title: labelNames[Random().nextInt(labelNames.length)],
      uid: uuid.v4(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class FakeCalendarViewFactory {
  List<TagModel> _tags = [];

  FakeCalendarViewFactory() {
    _tags = newTagsList(3);
  }

  List<TagModel> newTagsList(int amount){
    List<TagModel> newTags = [];

    FakeTagFactory tagsFactory = FakeTagFactory();

    for(int i = 0; i < amount; i++) {
      newTags.add(tagsFactory.fake());
    }

    return newTags;
  }

  NoteModel fakeItem() {
    final today = DateTime.now();
    final createdAt = today.add(Duration(days: Random().nextInt(3)));
    final updatedAt = createdAt.add(Duration(days: Random().nextInt(3)));

    return NoteModel(
        quillData: {},
        uuid: uuid.v4(),
        filesCount: Random().nextInt(2),
        isImportant: Random().nextBool(),
        createdAt: createdAt,
        updatedAt: updatedAt,
        tags: _tags.sublist(0, Random().nextInt(_tags.length)));
  }

  NotesGroupModel fakeGroup(String key, int amount) {
    return NotesGroupModel(groupKey: key, items: [
      for (var i = 1; i <= amount; i++) fakeItem()
    ]);
  }
}
