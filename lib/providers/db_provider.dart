import 'package:gapler/isar/shortcuts.dart';
import 'package:gapler/services/db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final isarProvider = FutureProvider((ref) async {
  Isar isar = await isarOpen();
  return isar;
});


final dbServiceProvider = FutureProvider((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return DbService(isar: isar);
});