import 'package:domo/fake/fake_factories.dart';
import 'package:domo/models/notes_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarViewItemsGroup extends StateNotifier<NotesGroupModel> {
  CalendarViewItemsGroup(super.state);

  void setInstance(NotesGroupModel group) {
    state = group;
  }
}

class CalendarViewDates extends StateNotifier<List<DateTime>> {
  CalendarViewDates(super.state);

  setState(List<DateTime> dates) {
    Set<DateTime> setOfDates = dates.toSet();
    List<DateTime> uniqueDatesList = setOfDates.toList();
    uniqueDatesList.sort((b, a) => a.compareTo(b));
    state = uniqueDatesList;
  }

  addDates(List<DateTime> dates) {
    Set<DateTime> setOfDates = {...state, ...dates};
    List<DateTime> uniqueDatesList = setOfDates.toList();
    uniqueDatesList.sort((b, a) => a.compareTo(b));
    state = uniqueDatesList;
  }
}

final calendarViewGroupProvider = StateNotifierProvider.family<
    CalendarViewItemsGroup, NotesGroupModel, String>((ref, key) {
  FakeCalendarViewFactory factory = FakeCalendarViewFactory();
  return CalendarViewItemsGroup(factory.fakeGroup(key, 7));
});

final calendarViewDatesProvider =
    StateNotifierProvider<CalendarViewDates, List<DateTime>>((ref) {
  return CalendarViewDates([]);
});

final infiniteScrollLock = StateProvider<bool>(
  (ref) => false,
);
