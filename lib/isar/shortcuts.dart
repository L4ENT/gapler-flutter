import 'package:domo/isar/collections/date_index_collection.dart';
import 'package:domo/isar/collections/notes_collection.dart';
import 'package:domo/isar/collections/tags_collection.dart';
import 'package:isar/isar.dart';

Future<Isar> isarOpen() async{
  final isar = await Isar.open([
    NoteCollectionItemSchema,
    DateIndexCollectionItemSchema,
    TagsCollectionItemSchema
  ]);
  return isar;
}