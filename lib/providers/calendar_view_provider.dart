import 'package:domo/fake/fake_factories.dart';
import 'package:domo/models/notes_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarViewItemsGroup extends StateNotifier<NotesGroupModel> {
  CalendarViewItemsGroup(super.state);

  void setInstance(NotesGroupModel group){
    state = group;
  }
}

final calendarViewProvider = StateNotifierProvider.family<
    CalendarViewItemsGroup, NotesGroupModel, String>((ref, key) {
  FakeCalendarViewFactory factory = FakeCalendarViewFactory();
  return CalendarViewItemsGroup(factory.fakeGroup(key, 7));
});
