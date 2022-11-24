import 'package:domo/models/note.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/utils.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditViewNote extends StateNotifier<NoteModel> {
  EditViewNote(super.state);

  void setInstance(NoteModel note) {
    state = note;
  }

  NoteModel updateWith(
      {Delta? quillDelta,
      String? uuid,
      int? filesCount,
      bool? isImportant,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<TagModel>? tags}) {

    NoteModel newNote = NoteModel(
        quillDelta: quillDelta ?? state.quillDelta,
        uuid: uuid ?? state.uuid,
        filesCount: filesCount ?? state.filesCount,
        isImportant: isImportant ?? state.isImportant,
        createdAt: createdAt ?? state.createdAt,
        updatedAt: updatedAt ?? state.updatedAt,
        tags: tags ?? state.tags);

    state = newNote;
    return newNote;
  }

  NoteModel addTag(TagModel tag) {
    List<TagModel> tags = [tag, ...state.tags];
    return updateWith(tags: tags);
  }

  NoteModel removeTag(TagModel tag) {
    List<TagModel> tags =
        state.tags.where((TagModel t) => t.uuid != tag.uuid).toList();
    return updateWith(tags: tags);
  }
}

final editViewProvider =
    StateNotifierProvider<EditViewNote, NoteModel>((ref) {
  return EditViewNote(getEmptyNote());
});
