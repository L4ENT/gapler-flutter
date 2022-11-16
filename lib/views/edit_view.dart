import 'package:domo/components/domo_icons.dart';
import 'package:domo/fake/fake_factories.dart';
import 'package:domo/models/note.dart';
import 'package:domo/providers/edit_view_manager_provider.dart';
import 'package:domo/providers/edit_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditViewState extends ConsumerState<EditView> {
  NoteModel? note;
  final quill.QuillController quillController = quill.QuillController.basic();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await onInitState(widget.uuid);
    });

    super.initState();
  }

  Future<void> onInitState(String? uuid) async {
    final editManager = ref.watch(editManagerProvider);
    if (uuid != null) {
      await editManager.loadEditor(uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Edit view provider
    NoteModel? noteModel = ref.watch(editViewProvider);

    // TODO: Refactor this
    if(noteModel != null) {
      final editManager = ref.read(editManagerProvider);
      quillController.document = quill.Document.fromDelta(noteModel.quillDelta);
      quillController.document.changes.listen((event) {
        Future.delayed(Duration.zero, () async {
          await editManager.pushToDb(noteModel);
        });
      });
    }

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

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Edit'),
          actions: [
            IconButton(
              icon: const Icon(DomoIcons.keyboardundo, size: 16),
              tooltip: 'Show Snackbar',
              onPressed: () {
                quillController.undo();
              },
            ),
            IconButton(
              icon: const Icon(DomoIcons.keyboardredo, size: 16),
              tooltip: 'Show Snackbar',
              onPressed: () {
                quillController.redo();
              },
            ),
            IconButton(
              icon: const Icon(DomoIcons.star, size: 16),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Show Snackbar',
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
  const EditView({super.key, this.uuid});

  final String? uuid;

  @override
  EditViewState createState() => EditViewState();
}
