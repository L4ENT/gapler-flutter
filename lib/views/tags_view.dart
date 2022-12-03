import 'package:domo/components/domo_icons.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/providers/tags_manager_provider.dart';
import 'package:domo/providers/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class TagsView extends ConsumerStatefulWidget {
  const TagsView({super.key});

  @override
  TagsViewState createState() => TagsViewState();
}

class TagsViewState extends ConsumerState {
  final _newTagController = TextEditingController();
  final _newTagFocus = FocusNode();

  TagModel? activeTag;

  bool newTagOnFocus = false;

  TextEditingController getController(TagModel tag) {
    final newController = TextEditingController(text: tag.title);
    return newController;
  }

  setActiveTag(TagModel? tag) {
    setState(() {
      activeTag = tag;
    });
  }

  setNewTagFocus(bool focused) {
    setState(() {
      newTagOnFocus = focused;
    });
  }

  bool isActive(TagModel tag) {
    return tag.uuid == activeTag?.uuid;
  }

  @override
  Widget build(BuildContext context) {
    List<TagModel> tags = ref.watch(tagsProvider);

    final tagsManager = ref.read(tagsManagerProvider);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
              trailing: newTagOnFocus
                  ? GestureDetector(
                      child: const Icon(Icons.add),
                      onTap: () {
                        final uuid = const Uuid().v4();
                        final title = _newTagController.text;
                        tagsManager.add(TagModel(title: title, uuid: uuid));
                        _newTagFocus.unfocus();
                      })
                  : null,
              title: Focus(
                onFocusChange: (focused) {
                  setNewTagFocus(focused);
                  if (focused) {
                    setActiveTag(null);
                  } else {
                    _newTagController.clear();
                  }
                },
                child: TextField(
                  controller: _newTagController,
                  focusNode: _newTagFocus,
                  enabled: true,
                  decoration: const InputDecoration(
                    hintText: 'New tag',
                  ),
                ),
              )),
          ...tags.map((tag) {
            final controller = getController(tag);
            return ListTile(
                minLeadingWidth: 14,
                leading: isActive(tag)
                    ? GestureDetector(
                        child: const Icon(Icons.delete, size: 22),
                        onTap: () {
                          Future.delayed(Duration.zero, () async {
                            tagsManager.remove(tag);
                          });
                        })
                    : Icon(DomoIcons.tag, size: 18, color: theme.colorScheme.primary),
                trailing: isActive(tag)
                    ? GestureDetector(
                        child: Icon(Icons.check, size: 24, color: theme.colorScheme.primary),
                        onTap: () {
                          Future.delayed(Duration.zero, () async {
                            await tagsManager
                                .replace(tag.copyWith(title: controller.text));
                          });
                          FocusScope.of(context).unfocus();
                          setActiveTag(null);
                        })
                    : null,
                title: Focus(
                  onFocusChange: (focused) {
                    if (focused) {
                      setActiveTag(tag);
                      final text = controller.text;
                      controller.selection = TextSelection(
                          baseOffset: text.length, extentOffset: text.length);
                    }
                  },
                  child: TextField(
                    enabled: true,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: tag.title,
                    ),
                    onSubmitted: (String? value) {
                      Future.delayed(Duration.zero, () async {
                        await tagsManager
                            .replace(tag.copyWith(title: controller.text));
                      });
                      FocusScope.of(context).unfocus();
                      setActiveTag(null);
                    },
                  ),
                ));
          }).toList()
        ],
      ),
    );
  }
}
