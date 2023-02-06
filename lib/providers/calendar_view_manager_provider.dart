import 'package:gapler/managers/calendar_view_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cvManagerProvider = Provider((ref) {
  return CalendarViewManager(ref);
});