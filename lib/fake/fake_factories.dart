import 'dart:math';

import 'package:gapler/models/tag.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';

import 'package:gapler/models/note.dart';
import 'package:gapler/models/notes_group.dart';

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
    return TagModel(
        title: labelNames[Random().nextInt(labelNames.length)],
        uuid: uuid.v4());
  }
}

class FakeCalendarViewFactory {
  List<TagModel> _tags = [];

  FakeCalendarViewFactory() {
    _tags = newTagsList(3);
  }

  List<TagModel> newTagsList(int amount) {
    List<TagModel> newTags = [];

    FakeTagFactory tagsFactory = FakeTagFactory();

    for (int i = 0; i < amount; i++) {
      newTags.add(tagsFactory.fake());
    }

    return newTags;
  }

  NoteModel fakeItem(
      {DateTime? createdAt, DateTime? updatedAt, List<TagModel>? tags}) {
    final today = DateTime.now();

    final rand = Random();

    final crAt = createdAt ??
        today.add(Duration(
            days: rand.nextInt(3),
            hours: rand.nextInt(5),
            minutes: rand.nextInt(60)));
    final upAt = updatedAt ?? crAt.add(Duration(days: Random().nextInt(3)));

    return NoteModel(
        quillDelta: Delta.fromJson([
          {"insert": "Gandalf was Grey\n"},
          {
            "attributes": {"bold": true},
            "insert": "But not gandalf the White"
          },
          {"insert": "\n\n"},
          {
            "attributes": {"bold": true},
            "insert": "And it is true"
          },
          {
            "attributes": {"header": 1},
            "insert": "\n"
          }
        ]),
        uuid: uuid.v4(),
        filesCount: Random().nextInt(2),
        isImportant: Random().nextBool(),
        createdAt: crAt,
        updatedAt: upAt,
        tags: tags ?? _tags.sublist(0, Random().nextInt(_tags.length)));
  }

  NotesGroupModel fakeGroup(String key, int amount) {
    return NotesGroupModel(
        groupKey: key, items: [for (var i = 1; i <= amount; i++) fakeItem()]);
  }
}
