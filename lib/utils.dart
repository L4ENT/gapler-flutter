
import 'package:intl/intl.dart';

List<DateTime> datesRangeToPast({required DateTime dt, int amount = 7}) {
  List<DateTime> dates = [];
  DateTime loopDate = dt;
  for(int i = 0; i < amount; i++) {
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