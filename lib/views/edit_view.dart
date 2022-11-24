import 'dart:async';
import 'package:domo/components/domo_icons.dart';
import 'package:domo/models/note.dart';
import 'package:domo/providers/edit_view_manager_provider.dart';
import 'package:domo/providers/edit_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditViewState extends ConsumerState<EditView> {
  final quill.QuillController quillController = quill.QuillController.basic();

  Timer? timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      onInit(widget.uuid);
    });
  }

  Future<void> onInit(String uuid) async {
    final editManager = ref.read(editManagerProvider);
    NoteModel note = await editManager.loadEditorByUuid(uuid);
    quillController.document = quill.Document.fromDelta(note.quillDelta);
    quillController.document.changes.listen((event) {
      timer?.cancel();
      timer = Timer(const Duration(milliseconds: 500), () {
        final editManager = ref.read(editManagerProvider);
        Future.delayed(Duration.zero, () async {
          await editManager.updateEditView(
              quillDelta: event.item1.compose(event.item2));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Current theme
    ThemeData theme = Theme.of(context);

    // Default icon styling on keyboard bar
    quill.QuillIconTheme iconTheme = quill.QuillIconTheme(
      iconSelectedColor: theme.colorScheme.primary,
      iconUnselectedColor: Colors.grey.shade700,
      iconSelectedFillColor: Colors.transparent,
      iconUnselectedFillColor: Colors.transparent,
      borderRadius: 40,
    );

    bool isImportant =
        ref.watch(editViewProvider.select((value) => value.isImportant));

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Edit'),
          actions: [
            IconButton(
              icon: const Icon(DomoIcons.keyboardundo, size: 16),
              tooltip: 'Undo',
              onPressed: () {
                quillController.undo();
              },
            ),
            IconButton(
              icon: const Icon(DomoIcons.keyboardredo, size: 16),
              tooltip: 'Redo',
              onPressed: () {
                quillController.redo();
              },
            ),
            IconButton(
              icon: Icon(DomoIcons.star,
                  size: 16,
                  color: isImportant
                      ? theme.colorScheme.primary
                      : Colors.grey.shade700),
              tooltip: 'Important',
              onPressed: () {
                Future.delayed(Duration.zero, () async {
                  final editManager = ref.read(editManagerProvider);
                  editManager.updateEditView(isImportant: !isImportant);
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Actions',
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // quill.QuillToolbar.basic(controller: quillController),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: quill.QuillEditor.basic(
                  controller: quillController,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.grey.shade200))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  quill.ToggleStyleButton(
                    controller: quillController,
                    attribute: const quill.BoldAttribute(),
                    icon: DomoIcons.bold,
                    iconSize: 16,
                    iconTheme: iconTheme,
                  ),
                  quill.ToggleStyleButton(
                    controller: quillController,
                    attribute: const quill.ItalicAttribute(),
                    icon: DomoIcons.italic,
                    iconSize: 16,
                    iconTheme: iconTheme,
                  ),
                  quill.ToggleStyleButton(
                    controller: quillController,
                    attribute: const quill.UnderlineAttribute(),
                    icon: DomoIcons.underline,
                    iconSize: 16,
                    iconTheme: iconTheme,
                  ),
                  quill.ToggleCheckListButton(
                    controller: quillController,
                    attribute: const quill.UnderlineAttribute(),
                    icon: DomoIcons.checkboxcircule,
                    iconSize: 20,
                    iconTheme: iconTheme,
                  ),
                  quill.ToggleStyleButton(
                    controller: quillController,
                    attribute: const quill.ListAttribute('bullet'),
                    icon: DomoIcons.keyboardunorderedlist,
                    iconSize: 20,
                    iconTheme: iconTheme,
                  ),
                  quill.ToggleStyleButton(
                    controller: quillController,
                    attribute: const quill.ListAttribute('ordered'),
                    icon: DomoIcons.keyboardorderedlist,
                    iconSize: 20,
                    iconTheme: iconTheme,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class EditView extends ConsumerStatefulWidget {
  const EditView({super.key, required this.uuid});

  final String uuid;

  @override
  EditViewState createState() => EditViewState();
}
