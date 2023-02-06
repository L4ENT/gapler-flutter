import 'package:isar/isar.dart';

part 'tags_collection.g.dart';

@collection
@Name("tags")
class TagsCollectionItem {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(unique: true, replace: true)
  late String uuid;

  late String title;

  @Name("created_at")
  late DateTime createdAt;

  @Name("updated_at")
  late DateTime updatedAt;
}
