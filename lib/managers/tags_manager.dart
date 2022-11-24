import 'package:domo/models/tag.dart';
import 'package:domo/providers/db_provider.dart';
import 'package:domo/providers/tags_provider.dart';
import 'package:domo/services/db_service.dart';
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
}