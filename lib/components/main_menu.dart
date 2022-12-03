import 'package:domo/components/view_condition.dart';
import 'package:domo/models/tag.dart';
import 'package:domo/providers/calendar_view_provider.dart';
import 'package:domo/providers/tags_manager_provider.dart';
import 'package:domo/providers/tags_provider.dart';
import 'package:domo/providers/url_provider.dart';
import 'package:flutter/material.dart';
import 'package:domo/components/domo_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const double _headPadding = 20;

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key, required this.icon, required this.title, this.onTap, required this.isActive});

  final Widget title;
  final IconData icon;
  final GestureTapCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 48,
          child: Container(
            color: isActive ? colors.primary.withAlpha(25) : null,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Icon(icon,
                    size: 16, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                title
              ],
            ),
          ),
        ),
      ),
    );
  }
  //
  // @override
  // double? get horizontalTitleGap => 0;
  //
  // @override
  // EdgeInsetsGeometry? get contentPadding => EdgeInsets.zero;
}

class MainMenu extends ConsumerStatefulWidget {
  const MainMenu({super.key});

  @override
  MainMenuSate createState() => MainMenuSate();
}

class MainMenuSate extends ConsumerState {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final tagsManager = ref.read(tagsManagerProvider);
      await tagsManager.loadTags();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewConditionState = ref.read(viewConditionProvider.notifier);

    final theme = Theme.of(context);

    List<TagModel> tags = ref.watch(tagsProvider);

    String url = ref.read(urlProvider);
    final urlState = ref.read(urlProvider.notifier);

    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + _headPadding),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Theme.of(context).colorScheme.outline))),
          padding: const EdgeInsets.only(bottom: _headPadding) +
              const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('June 20, 2022 - Saturday'),
              Icon(DomoIcons.settings,
                  size: 16, color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            MenuItem(
              icon: DomoIcons.calendar,
              title: const Text('All'),
              isActive: url == '/',
              onTap: () {
                viewConditionState.update((state) => ViewCondition());
                Navigator.of(context).pop();
                context.go('/');
                urlState.update((state) => '/');
              },
            ),
            MenuItem(
              icon: DomoIcons.star,
              title: const Text('Important'),
              isActive: url == '/important',
              onTap: () {
                viewConditionState
                    .update((state) => ViewCondition(isImportant: true));
                Navigator.of(context).pop();
                context.go('/important');
                urlState.update((state) => '/important');
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text('Tags'),
        ),
        const SizedBox(height: 8),
        Column(
          children: tags.map((tag) {
            return MenuItem(
              icon: DomoIcons.tag,
              title: Text(tag.title),
              isActive: url == '/calendar/tag/${tag.uuid}/${tag.title}',
              onTap: () {
                viewConditionState
                    .update((state) => ViewCondition(tagUUID: tag.uuid));
                Navigator.of(context).pop();
                String url = '/calendar/tag/${tag.uuid}/${tag.title}';
                context.go(url);
                urlState.update((state) => url);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            child: Text(
              'Edit tags',
              style: TextStyle(fontSize: 12, color: theme.colorScheme.primary),
            ),
            onTap: () {
              context.push('/tags');
            },
          ),
        )
      ],
    );
  }
}
