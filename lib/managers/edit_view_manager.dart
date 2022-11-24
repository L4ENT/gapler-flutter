import 'package:domo/models/note.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:domo/providers/db_provider.dart';
import 'package:domo/providers/edit_view_provider.dart';
import 'package:domo/utils.dart';
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
      return getEmptyNote(uuid: byUuid);
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

    final dbService = await ref.read(dbServiceProvider.future);
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

    await dbService.notes.putNote(editState);

    final group = await dbService.notes.getNotesDayGroupByDate(byDate: editState.createdAt);
    final groupState = ref.read(calendarViewGroupProvider(group.groupKey).notifier);
    groupState.setInstance(group);
  }
}
