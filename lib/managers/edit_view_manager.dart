import 'package:domo/models/note.dart';
import 'package:domo/providers/db_provider.dart';
import 'package:domo/providers/edit_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditViewManager {
  EditViewManager(this.ref);

  final Ref ref;

  Future<NoteModel?> getByUuid(String byUuid) async{
    final dbService = await ref.read(dbServiceProvider.future);
    NoteModel? noteModel = await dbService.notes.getByUuid(byUuid);
    return noteModel;
  }

  Future<void> loadEditor(String byUuid) async{
    NoteModel? noteModel = await getByUuid(byUuid);
    final notifier = ref.read(editViewProvider.notifier);
    notifier.setInstance(noteModel);
  }

  Future<void> pushToDb(NoteModel noteModel) async{
    final dbService = await ref.read(dbServiceProvider.future);
    await dbService.notes.putNote(noteModel);
  }
}