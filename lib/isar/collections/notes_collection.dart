import 'package:domo/isar/collections/tags_collection.dart';
import 'package:isar/isar.dart';

part 'notes_collection.g.dart';

@collection
@Name("notes")
class NoteCollectionItem {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(unique: true, replace: true)
  late String uuid;

  @Name("quill_data_json")
  String quillDataJson = '{"ops":[]}';

  @Name("files_count")
  int filesCount = 0;

  @Name("is_important")
  bool isImportant = false;

  @Name("created_at")
  late DateTime createdAt;

  @Name("updated_at")
  late DateTime updatedAt;

  final tags = IsarLinks<TagsCollectionItem>();
}

@embedded
class TagEmbedded {
  late String uuid;
  late String title;
}