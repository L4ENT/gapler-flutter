import 'package:domo/models/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditViewNote extends StateNotifier<NoteModel?> {
  EditViewNote(super.state);

  void setInstance(NoteModel? note) {
    state = note;
  }
}


final editViewProvider = StateNotifierProvider.autoDispose<EditViewNote, NoteModel?>((ref) {
  return EditViewNote(null);
});