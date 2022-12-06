import 'package:gapler/models/note.dart';
import 'package:gapler/models/tag.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

List<DateTime> datesRangeToPast({required DateTime dt, int amount = 7}) {
  List<DateTime> dates = [];
  DateTime loopDate = dt;
  for (int i = 0; i < amount; i++) {
    dates.add(loopDate.add(Duration(days: -i)));
  }
  return dates;
}

String getDateOnlyString(DateTime dt) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dt);
  return formatted;
}

String getHumanDate(DateTime dt) {
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final String formatted = formatter.format(dt);
  return formatted;
}

class ViewGroupKey {
  static String dateKeyFormat(DateTime dt) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dt);
    return formatted;
  }

  static String dayGroupKeyByDate(DateTime byDate) {
    return 'days:${dateKeyFormat(byDate)}';
  }

  static String buildDateGroupKey(String groupKey, DateTime byDate) {
    return '$groupKey:${dateKeyFormat(byDate)}';
  }
}

NoteModel getEmptyNote({
  String? uuid,
  bool? isImportant,
  List<TagModel>? tags,
}) {
  DateTime today = DateTime.now();
  return NoteModel(
    quillDelta: Delta.fromJson([]),
    uuid: uuid ?? const Uuid().v4(),
    filesCount: 0,
    isImportant: isImportant ?? false,
    createdAt: today,
    updatedAt: today,
    tags: tags ?? [],
  );
}

bool isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String formatForCv(DateTime dt) {
  final today = DateTime.now();
  DateFormat formatter;
  if(today.year == dt.year) {
    formatter = DateFormat('d MMM - EEEE');
  } else {
    formatter = DateFormat('d MMM, YYYY - EEEE');
  }

  final String formatted = formatter.format(dt);
  return formatted;
}