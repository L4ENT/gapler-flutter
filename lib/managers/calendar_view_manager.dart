import 'package:domo/components/view_condition.dart';
import 'package:domo/models/notes_group.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:domo/providers/db_provider.dart';
import 'package:domo/services/db_service.dart';
import 'package:domo/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarViewManager {
  CalendarViewManager(this.ref);

  final Ref ref;

  Future<void> initProviders() async {
    DbService dbService = await ref.watch(dbServiceProvider.future);

    // View conditions
    ViewCondition vCond = ref.read(viewConditionProvider);

    // All dates that contains non zero amount of notes
    List<DateTime> dates = await dbService.notes
        .getNoteDatesLte(fromDate: DateTime.now(), vCond: vCond);

    // Init calendar view dates state
    final cvDatesState = ref.watch(calendarViewDatesProvider.notifier);
    cvDatesState.setState(dates);

    // Init state for any group of notes for calendar view
    for (DateTime dt in dates) {
      final String key = ViewGroupKey.dayGroupKeyByDate(dt);
      final groupState = ref.watch(calendarViewGroupProvider(key).notifier);
      final group = await dbService.notes
          .getNotesDayGroupByDate(byDate: dt, vCond: vCond);
      groupState.setInstance(group);
    }
  }

  Future<void> loadBatch({required DateTime dt, int amount = 7}) async {
    DbService dbService = await ref.watch(dbServiceProvider.future);

    // View conditions
    ViewCondition vCond = ref.read(viewConditionProvider);

    // All dates that contains non zero amount of notes
    List<DateTime> dates =
        await dbService.notes.getNoteDatesLte(fromDate: dt, vCond: vCond);

    // Init calendar view dates state
    final cvDatesState = ref.watch(calendarViewDatesProvider.notifier);
    cvDatesState.addDates(dates);

    // Init state for any group of notes for calendar view
    for (DateTime dt in dates) {
      final String key = ViewGroupKey.dayGroupKeyByDate(dt);
      final groupState = ref.watch(calendarViewGroupProvider(key).notifier);
      final group = await dbService.notes
          .getNotesDayGroupByDate(byDate: dt, vCond: vCond);
      groupState.setInstance(group);
    }
  }
}
