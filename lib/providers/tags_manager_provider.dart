import 'package:gapler/managers/tags_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tagsManagerProvider = Provider((ref) {
  return TagsManager(ref);
});
