import 'package:domo/domo_icons.dart';
import 'package:flutter/material.dart';
import 'main_menu.dart';

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

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CalendarView> createState() => _CalendarViewState();
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
      required this.labels,
      required this.important,
      required this.files});

  final String text;
  final List labels;
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
    if (labels.isNotEmpty) {
      itemParts.add(const SizedBox(height: 6));
      itemParts.add(Row(
        children: labels.map((e) => _ItemLabel(title: e)).toList(),
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
          border: Border.all(width: 1, color: Theme.of(context).colorScheme.outline)),
      child: Column(
        children: itemParts,
      ),
    );
  }
}

class _ItemBatch extends StatelessWidget {
  const _ItemBatch({super.key, required this.items});

  final List items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 40,
      width: 180,
      child: Column(
        children: items
            .map((item) => _Item(
                  text: item['text'],
                  labels: item['labels'],
                  important: item['important'],
                  files: item['files'],
                ))
            .toList(),
      ),
    );
  }
}

class _CalendarViewState extends State<CalendarView> {
  List data = [
    {
      'date': '2022-01-03',
      'items': [
        {
          'uuid': '123',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 1
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 1
        },
        {
          'uuid': '124',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 1
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 2
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '126',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': false,
          'files': 1
        }
      ]
    },
    {
      'date': '2022-01-02',
      'items': [
        {
          'uuid': '123',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': false,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '124',
          'text': 'Mom birthday',
          'labels': [],
          'important': false,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 0
        },
        {
          'uuid': '126',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': false,
          'files': 1
        }
      ]
    },
    {
      'date': '2022-01-01',
      'items': [
        {
          'uuid': '123',
          'text': 'Mom birthday',
          'labels': [],
          'important': false,
          'files': 1
        },
        {
          'uuid': '124',
          'text': 'Mom birthday',
          'labels': [],
          'important': true,
          'files': 1
        },
        {
          'uuid': '125',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 1
        },
        {
          'uuid': '126',
          'text': 'Mom birthday',
          'labels': ['Home', 'Work'],
          'important': true,
          'files': 1
        }
      ]
    }
  ];

  int getItemVolume(Map item) {
    int volume = 0;
    if (item.containsKey('text')) {
      volume++;
    }

    if (item.containsKey('labels') && item['labels'].length > 0) {
      volume++;
    }

    if (item['important'] || item['files'] > 0) {
      volume++;
    }

    return volume;
  }

  List itemsToBatches(List items) {
    List batches = [];

    int currentBatchSize = 0;
    List batch = [];

    for (int i = 0; i < items.length; i++) {
      Map item = items[i];
      int itemVolume = getItemVolume(item);

      if (currentBatchSize + itemVolume > 6) {
        batches.add(batch);
        batch = [item];
        currentBatchSize = itemVolume;
      } else {
        batch.add(item);
        currentBatchSize += itemVolume;
      }
    }
    if (batch.isNotEmpty) {
      batches.add(batch);
    }
    return batches;
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('the-end-of-notes');
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: const Drawer(child: MainMenu()),
        body: CustomScrollView(
          reverse: true,
          slivers: data
              .map((group) => SliverToBoxAdapter(
                      child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(group['date']),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 250,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: itemsToBatches(group['items'])
                                .map<Widget>(
                                    (batch) => _ItemBatch(items: batch))
                                .toList()),
                      )
                    ],
                  )))
              .toList(),
        ),
        bottomNavigationBar: const _BottomBar());
  }
}
