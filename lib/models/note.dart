import 'package:domo/models/tag.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteModel {
  final Delta quillDelta;
  final String uuid;
  final int filesCount;
  final bool isImportant;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TagModel> tags;

  NoteModel(
      {required this.quillDelta,
      required this.uuid,
      required this.filesCount,
      required this.isImportant,
      required this.createdAt,
      required this.updatedAt,
      required this.tags});

  String get longText {
    String text = Document.fromDelta(quillDelta).toPlainText();
    text = text.replaceAll("\n", " ");
    if(text.length > 41) {
      return '${text.substring(0, 38)}...';
    } else {
      return text;
    }
  }

  String get shortText {
    String text = Document.fromDelta(quillDelta).toPlainText();
    text = text.replaceAll("\n", " ");
    if(text.length > 41) {
      return '${text.substring(0, 38)}...';
    } else {
      return text;
    }
  }

  int get volume{
    int volume = 0;
    if (longText.isNotEmpty) {
      volume++;
    }

    if (longText.length > 20) {
      volume++;
    }

    if (tags.isNotEmpty) {
      volume++;
    }

    if (isImportant || filesCount > 0) {
      volume++;
    }

    return volume;
  }
}
