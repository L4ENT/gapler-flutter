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

  List<TagEmbedded> tags = [];
}

@embedded
class TagEmbedded {
  late String uuid;
  late String title;
}