import 'dart:async';
import 'package:domo/components/domo_icons.dart';
import 'package:domo/models/note.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/providers/edit_view_manager_provider.dart';
import 'package:domo/providers/edit_view_provider.dart';
import 'package:domo/providers/tags_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Menu { editTags, shareNote, removeNote }

class _Tag extends StatelessWidget {
  const _Tag({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20)),
        child: Text(title, style: const TextStyle(fontSize: 12)),
      ),
      onTap: () {
        context.push('/edit/tags');
      },
    );
  }
}

class EditNoteTagsSate extends ConsumerState {
  List<TagModel> allTags = [];

  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      final tags = await _getAllTags();
      setState(() {
        allTags = tags;
      });
    });
  }

  Future<List<TagModel>> _getAllTags() async {
    final tagsManager = ref.read(tagsManagerProvider);
    return await tagsManager.getAll();
  }

  @override
  Widget build(BuildContext context) {
    List<TagModel> noteTags =
        ref.watch(editViewProvider.select((value) => value.tags));

    final tagsUuids = noteTags.map((e) => e.uuid).toList();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: allTags.map((TagModel t) {
          return Row(
            key: Key('row:${t.uuid}'),
            children: [
              Checkbox(
                  key: Key('row:checkbox:${t.uuid}'),
                  value: tagsUuids.contains(t.uuid),
                  onChanged: (checked) {
                    final editManager = ref.read(editManagerProvider);
                    if (checked == true) {
                      editManager.addTag(t);
                    } else {
                      editManager.removeTag(t);
                    }
                  }),
              const SizedBox(width: 10),
              Text(key: Key('row:text:${t.uuid}'), t.title)
            ],
          );
        }).toList(),
      ),
    );
  }
}

class EditNoteTagsView extends ConsumerStatefulWidget {
  const EditNoteTagsView({super.key});

  @override
  EditNoteTagsSate createState() => EditNoteTagsSate();
}

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
    if(note.quillDelta.isNotEmpty) {
      quillController.document = quill.Document.fromDelta(note.quillDelta);
    }
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

    List<TagModel> tags =
        ref.watch(editViewProvider.select((value) => value.tags));

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
            PopupMenuButton<Menu>(
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      PopupMenuItem<Menu>(
                        value: Menu.editTags,
                        child: Row(
                          children: [
                            const Icon(DomoIcons.tag, size: 14),
                            const SizedBox(width: 8),
                            Text('Edit tags', style: theme.textTheme.bodyText2)
                          ],
                        ),
                        onTap: () {
                          context.push('/edit/tags');
                        },
                      ),
                      PopupMenuItem<Menu>(
                        value: Menu.shareNote,
                        child: Row(
                          children: [
                            const Icon(Icons.share, size: 14),
                            const SizedBox(width: 8),
                            Text('Share', style: theme.textTheme.bodyText2)
                          ],
                        ),
                        onTap: () {
                          debugPrint('Share note');
                        },
                      ),
                      PopupMenuItem<Menu>(
                        value: Menu.removeNote,
                        child: Text('Remove', style: theme.textTheme.bodyText2),
                        onTap: () {
                          debugPrint('Remove note');
                        },
                      ),
                    ]),
          ],
        ),
        body: Column(
          children: [
            // quill.QuillToolbar.basic(controller: quillController),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16) +
                  const EdgeInsets.only(top: 16),
              child:
                  Row(children: tags.map((e) => _Tag(title: e.title)).toList()),
            ),
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
