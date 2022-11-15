import 'package:domo/models/tag.dart';

class NoteModel {
  final Map<dynamic, dynamic> quillData;
  final String uuid;
  final int filesCount;
  final bool isImportant;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TagModel> tags;

  NoteModel(
      {required this.quillData,
      required this.uuid,
      required this.filesCount,
      required this.isImportant,
      required this.createdAt,
      required this.updatedAt,
      required this.tags});

  String get shortText {
    return 'Amazing notes is the way to amazing';
  }
}
