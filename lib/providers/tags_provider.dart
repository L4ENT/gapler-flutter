import 'package:domo/models/tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsStateNotifier extends StateNotifier<List<TagModel>> {
  TagsStateNotifier(super.state);

  void setState(List<TagModel> tags) {
    state = tags;
  }

  void add(TagModel tag) {
    state = [...state, tag];
  }

  void remove(TagModel tag) {
    state = state.where((tagEl) => tagEl.uuid != tag.uuid).toList();
  }
}

final tagsProvider =
    StateNotifierProvider<TagsStateNotifier, List<TagModel>>((ref) {
  return TagsStateNotifier([]);
});
