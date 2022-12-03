import 'package:domo/components/view_condition.dart';
import 'package:domo/models/note.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:domo/providers/db_provider.dart';
import 'package:domo/providers/edit_view_provider.dart';
import 'package:domo/providers/tags_provider.dart';
import 'package:domo/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditViewManager {
  EditViewManager(this.ref);

  final Ref ref;

  Future<NoteModel> getByUuid(String byUuid) async {
    final dbService = await ref.read(dbServiceProvider.future);
    NoteModel? noteModel = await dbService.notes.getByUuid(byUuid);
    if (noteModel != null) {
      return noteModel;
    } else {
      final viewCondition = ref.read(viewConditionProvider);

      final isImportant = viewCondition.isImportant;

      List<TagModel> tags = [];

      final tagUuid = viewCondition.tagUUID;
      if (tagUuid != null) {
        final allTags = ref.read(tagsProvider);
        try {
          TagModel tag = allTags.firstWhere(
            (element) => element.uuid == tagUuid,
          );
          tags.add(tag);
        } on StateError {
          debugPrint('No such tag');
        }
      }

      return getEmptyNote(uuid: byUuid, isImportant: isImportant, tags: tags);
    }
  }

  Future<NoteModel> loadEditorByUuid(String byUuid) async {
    final notifier = ref.read(editViewProvider.notifier);
    NoteModel note = await getByUuid(byUuid);
    notifier.setInstance(note);
    return note;
  }

  Future<void> pushToDb(NoteModel noteModel) async {
    final dbService = await ref.read(dbServiceProvider.future);
    await dbService.notes.putNote(noteModel);
  }

  Future<void> updateEditView(
      {Delta? quillDelta,
      String? uuid,
      int? filesCount,
      bool? isImportant,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<TagModel>? tags}) async {
    final editViewNotifier = ref.read(editViewProvider.notifier);

    final editState = editViewNotifier.updateWith(
      quillDelta: quillDelta,
      filesCount: filesCount,
      isImportant: isImportant,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tags: tags,
      uuid: uuid,
    );

    await _dbUpdateNote(editState);
    await _updateCalendarView(editState);
  }

  Future<void> addTag(TagModel tag) async {
    final editViewNotifier = ref.read(editViewProvider.notifier);

    final editState = editViewNotifier.addTag(tag);

    await _dbUpdateNote(editState);
    await _updateCalendarView(editState);
  }

  Future<void> removeTag(TagModel tag) async {
    final editViewNotifier = ref.read(editViewProvider.notifier);

    final editState = editViewNotifier.removeTag(tag);

    await _dbUpdateNote(editState);
    await _updateCalendarView(editState);
  }

  Future<void> _dbUpdateNote(NoteModel note) async {
    final dbService = await ref.read(dbServiceProvider.future);
    await dbService.notes.putNote(note);
  }

  Future<void> _updateCalendarView(NoteModel note) async {
    // View conditions
    ViewCondition vCond = ref.read(viewConditionProvider);
    final dbService = await ref.read(dbServiceProvider.future);
    final group = await dbService.notes
        .getNotesDayGroupByDate(byDate: note.createdAt, vCond: vCond);
    final groupState =
        ref.read(calendarViewGroupProvider(group.groupKey).notifier);
    groupState.setInstance(group);
  }

  Future<void> remove(NoteModel noteModel) async {
    final dbService = await ref.read(dbServiceProvider.future);
    await dbService.notes.remove(noteModel.uuid);
    await _updateCalendarView(noteModel);
  }
}
