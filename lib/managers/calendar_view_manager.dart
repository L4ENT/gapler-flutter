import 'package:domo/models/notes_group.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:domo/providers/db_provider.dart';
import 'package:domo/services/db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarViewManager {
  CalendarViewManager(this.ref);

  final Ref ref;

  Future<void> loadBatch({required DateTime dt, int amount = 7}) async {
    DbService dbService = await ref.watch(dbServiceProvider.future);
    List<NotesGroupModel> groups =
        await dbService.notes.getNotesGroupsDaysBatch(dt: dt, amount: amount);
    for (NotesGroupModel group in groups) {
      CalendarViewItemsGroup groupState =
          ref.watch(calendarViewProvider(group.groupKey).notifier);
      groupState.setInstance(group);
    }
  }
}
