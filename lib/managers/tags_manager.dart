import 'package:gapler/models/tag.dart';
import 'package:gapler/providers/calendar_view_manager_provider.dart';
import 'package:gapler/providers/db_provider.dart';
import 'package:gapler/providers/tags_provider.dart';
import 'package:gapler/services/db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsManager {
  TagsManager(this.ref);

  final Ref ref;

  Future<List<TagModel>> getAll() async {
    DbService dbService = await ref.read(dbServiceProvider.future);
    return await dbService.tags.getAll();
  }

  Future<List<TagModel>> loadTags() async {
    DbService dbService = await ref.read(dbServiceProvider.future);
    final tags = await dbService.tags.getAll();

    final tagsState = ref.read(tagsProvider.notifier);
    tagsState.setState(tags);
    return tags;
  }

  Future<void> add(TagModel tag) async {
    DbService dbService = await ref.read(dbServiceProvider.future);
    dbService.tags.put(tag);

    final tagsState = ref.read(tagsProvider.notifier);
    tagsState.add(tag);
  }

  Future<void> replace(TagModel tag) async {
    DbService dbService = await ref.read(dbServiceProvider.future);
    dbService.tags.put(tag);

    final tagsState = ref.read(tagsProvider.notifier);
    tagsState.replace(tag);

    final calendarViewManager = ref.read(cvManagerProvider);
    await calendarViewManager.initProviders();
  }

  Future<void> remove(TagModel tag) async {
    DbService dbService = await ref.read(dbServiceProvider.future);
    dbService.tags.remove(tag);

    final tagsState = ref.read(tagsProvider.notifier);
    tagsState.remove(tag);

    final calendarViewManager = ref.read(cvManagerProvider);
    await calendarViewManager.initProviders();
  }
}