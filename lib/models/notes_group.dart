import 'package:domo/models/note.dart';

class NotesGroupModel {
  final String groupKey;
  final List<NoteModel> items;

  NotesGroupModel({required this.groupKey, required this.items});
}