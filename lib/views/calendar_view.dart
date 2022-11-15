import 'package:domo/models/note.dart';
import 'package:domo/models/notes_group.dart';
import 'package:domo/providers/calendar_view_manager_provider.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:domo/components/domo_icons.dart';
import 'package:domo/components/main_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: CircleBorder(
            side: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.outline)),
        color: Colors.white,
      ),
      child: Icon(icon, size: 18, color: Colors.grey),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
                top: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.outline))),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _BottomBarItem(icon: DomoIcons.attachment),
            SizedBox(width: 10),
            _BottomBarItem(icon: DomoIcons.note)
          ],
        ));
  }
}

class _ItemLabel extends StatelessWidget {
  const _ItemLabel({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: Text(title, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
      {super.key,
      required this.text,
      required this.tags,
      required this.important,
      required this.files});

  final String text;
  final List tags;
  final bool important;
  final int files;

  @override
  Widget build(BuildContext context) {
    List<Widget> itemParts = [];
    if (text.isNotEmpty) {
      itemParts.add(Align(
        alignment: Alignment.centerLeft,
        child: Text(text),
      ));
    }
    if (tags.isNotEmpty) {
      itemParts.add(const SizedBox(height: 6));
      itemParts.add(Row(
        children: tags.map((e) => _ItemLabel(title: e)).toList(),
      ));
    }

    if (important || files > 0) {
      itemParts.add(const SizedBox(height: 6));
      List<Widget> bottomParts = [];
      if (files > 0) {
        bottomParts.add(Row(
          children: [
            Icon(DomoIcons.attachment,
                size: 12, color: Theme.of(context).colorScheme.primary),
            Text(files.toString())
          ],
        ));
      }
      if (important) {
        bottomParts.add(Icon(DomoIcons.star,
            size: 12, color: Theme.of(context).colorScheme.primary));
      }
      itemParts.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: bottomParts,
      ));
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.outline)),
      child: Column(
        children: itemParts,
      ),
    );
  }
}

class _ItemBatch extends StatelessWidget {
  const _ItemBatch({super.key, required this.items});

  final List<NoteModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 40,
      width: 180,
      child: Column(
        children: items
            .map((item) => _Item(
                  text: item.shortText,
                  tags: item.tags.map((e) => e.title).toList(),
                  important: item.isImportant,
                  files: item.filesCount,
                ))
            .toList(),
      ),
    );
  }
}

class CalendarView extends ConsumerWidget {
  const CalendarView(
      {super.key, required this.title, required this.groupKeyPrefix});

  final String title;
  final String groupKeyPrefix;

  int getItemVolume(NoteModel note) {
    int volume = 0;
    if (note.shortText.isNotEmpty) {
      volume++;
    }

    if (note.tags.isNotEmpty) {
      volume++;
    }

    if (note.isImportant || note.filesCount > 0) {
      volume++;
    }

    return volume;
  }

  List<List<NoteModel>> itemsToBatches(List<NoteModel> items) {
    List<List<NoteModel>> batches = [];

    int currentBatchSize = 0;
    List<NoteModel> batch = [];

    for (int i = 0; i < items.length; i++) {
      NoteModel note = items[i];
      int itemVolume = getItemVolume(note);

      if (currentBatchSize + itemVolume > 6) {
        batches.add(batch);
        batch = [note];
        currentBatchSize = itemVolume;
      } else {
        batch.add(note);
        currentBatchSize += itemVolume;
      }
    }
    if (batch.isNotEmpty) {
      batches.add(batch);
    }
    return batches;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(cvManagerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: const Drawer(child: MainMenu()),
        body: CustomScrollView(
          reverse: true,
          slivers: [
            '2022-01-10',
            '2022-01-09',
            '2022-01-08',
            '2022-01-07',
            '2022-01-06',
            '2022-01-05',
            '2022-01-04',
            '2022-01-03',
            '2022-01-02',
            '2022-01-01',
            '2021-12-31',
            '2021-12-30',
            '2021-12-29',
            '2021-12-27',
          ].map((String dateString) {
            NotesGroupModel itemsGroup =
                ref.watch(calendarViewProvider('$groupKeyPrefix:$dateString'));
            return SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(itemsGroup.groupKey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 280,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: itemsToBatches(itemsGroup.items)
                          .map<Widget>((batch) => _ItemBatch(items: batch))
                          .toList()),
                )
              ],
            ));
          }).toList(),
        ),
        bottomNavigationBar: const _BottomBar());
  }
}
