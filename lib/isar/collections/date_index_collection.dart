import 'package:isar/isar.dart';

part 'date_index_collection.g.dart';

@collection
@Name("date_index")
class DateIndexCollectionItem {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(unique: true, replace: true)
  late DateTime date;

  int count = 0;
}
