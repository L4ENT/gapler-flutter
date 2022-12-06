import 'package:gapler/managers/edit_view_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editManagerProvider = Provider((ref) {
  return EditViewManager(ref);
});
