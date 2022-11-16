import 'dart:math';

import 'package:domo/models/note.dart';
import 'package:domo/models/notes_group.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/providers/calendar_view_manager_provider.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:domo/utils.dart';
import 'package:flutter/material.dart';
import 'package:domo/components/domo_icons.dart';
import 'package:domo/components/main_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: Text(title, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _ItemTags extends StatelessWidget {
  const _ItemTags({super.key, required this.tags});

  final List<TagModel> tags;

  List<String> getStrings() {
    List<String> strings = [];

    int totalTextLength = 0;
    int includedCount = 0;
    for (TagModel tag in tags) {
      if (totalTextLength + tag.title.length > 14) {
        break;
      }
      if (tag.title.length > 14) {
        final String shortTitle = '${tag.title.substring(0, 10)}...';
        strings.add(shortTitle);
        totalTextLength += shortTitle.length;
      } else {
        strings.add(tag.title);
        totalTextLength += tag.title.length;
      }
      includedCount++;
    }
    if (includedCount < tags.length) {
      strings.add('+1');
    }
    return strings;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getStrings().map((title) => _ItemLabel(title: title)).toList(),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
      {super.key,
      required this.text,
      required this.uuid,
      required this.tags,
      required this.important,
      required this.files});

  final String text;
  final String uuid;
  final List<TagModel> tags;
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
      itemParts.add(_ItemTags(tags: tags));
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

    return GestureDetector(
      child: Container(
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
      ),
      onTap: () {
        context.push('/edit/$uuid');
      },
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
                  key: Key('item:${item.uuid}'),
                  uuid: item.uuid,
                  text: item.shortText,
                  tags: item.tags,
                  important: item.isImportant,
                  files: item.filesCount,
                ))
            .toList(),
      ),
    );
  }
}

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView(
      {super.key, required this.title, required this.groupKeyPrefix});

  final String title;
  final String groupKeyPrefix;

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends ConsumerState<CalendarView> {
  final ScrollController _scrollController = ScrollController();
  bool loading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await onInitState();
    });

    _scrollController.addListener(() {
      onScroll();
    });

    super.initState();
  }

  Future<void> onInitState() async {
    final cvManager = ref.watch(cvManagerProvider);
    await cvManager.initProviders();
  }

  void onScroll() {
    final percent =
        _scrollController.offset / _scrollController.position.maxScrollExtent;

    final infScrollLock = ref.read(infiniteScrollLock);

    if (percent > 0.7 && !infScrollLock) {
      ref.read(infiniteScrollLock.notifier).state = true;
      final cvManager = ref.read(cvManagerProvider);
      List<DateTime> cvDates = ref.read(calendarViewDatesProvider);
      if (cvDates.isNotEmpty) {
        DateTime minDate = cvDates.last;
        Future.delayed(Duration.zero, () async {
          DateTime byDate = minDate.add(const Duration(days: -1));
          await cvManager.loadBatch(dt: byDate, amount: 20);
          ref.read(infiniteScrollLock.notifier).state = false;
        });
      }
    }
  }

  List<List<NoteModel>> itemsToBatches(List<NoteModel> items) {
    List<List<NoteModel>> batches = [];

    int currentBatchSize = 0;
    List<NoteModel> batch = [];

    for (int i = 0; i < items.length; i++) {
      NoteModel note = items[i];

      if (currentBatchSize + note.volume > 9) {
        batches.add(batch);
        batch = [note];
        currentBatchSize = note.volume;
      } else {
        batch.add(note);
        currentBatchSize += note.volume;
      }
    }
    if (batch.isNotEmpty) {
      batches.add(batch);
    }
    return batches;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> cvDates = ref.watch(calendarViewDatesProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: const Drawer(child: MainMenu()),
        body: CustomScrollView(
            reverse: true,
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    DateTime groupDate = cvDates[index];
                    NotesGroupModel itemsGroup = ref.watch(
                        calendarViewGroupProvider(
                            ViewGroupKey.buildDateGroupKey(
                                widget.groupKeyPrefix, groupDate)));

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(getHumanDate(groupDate)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          // TODO: Calc height before render from items batches
                          height: 300,
                          child: ListView(
                              key: Key('${itemsGroup.groupKey}:listview'),
                              scrollDirection: Axis.horizontal,
                              children: itemsToBatches(itemsGroup.items)
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                return _ItemBatch(
                                    key: Key(
                                        '${itemsGroup.groupKey}:listview:${entry.key}'),
                                    items: entry.value);
                              }).toList()),
                        )
                      ],
                    );
                  },
                  childCount: cvDates.length,
                ),
              ),
            ]
            // cvDates.map((DateTime groupDate) {
            //   // Getting notes group from provider by groupKey
            //   NotesGroupModel itemsGroup = ref.watch(calendarViewGroupProvider(
            //       ViewGroupKey.buildDateGroupKey(
            //           widget.groupKeyPrefix, groupDate)));
            //
            //   return SliverToBoxAdapter(
            //       key: Key(itemsGroup.groupKey),
            //       child: Column(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.only(left: 16),
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: Text(getHumanDate(groupDate)),
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.only(left: 16),
            //             margin: const EdgeInsets.symmetric(vertical: 16),
            //             // TODO: Calc height before render from items batches
            //             height: 300,
            //             child: ListView(
            //                 key: Key('${itemsGroup.groupKey}:listview'),
            //                 scrollDirection: Axis.horizontal,
            //                 children: itemsToBatches(itemsGroup.items)
            //                     .asMap()
            //                     .entries
            //                     .map<Widget>((entry) {
            //                   return _ItemBatch(
            //                       key: Key(
            //                           '${itemsGroup.groupKey}:listview:${entry.key}'),
            //                       items: entry.value);
            //                 }).toList()),
            //           )
            //         ],
            //       ));
            // }).toList(),
            ),
        bottomNavigationBar: const _BottomBar());
  }
}
