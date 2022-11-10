import 'package:flutter/material.dart';
import 'domo_icons.dart';

const double _headPadding = 20;

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key, required this.icon, required this.title, this.onTap});

  final Widget title;
  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon,
                  size: 16, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              title
            ],
          ),
        ));
  }
  //
  // @override
  // double? get horizontalTitleGap => 0;
  //
  // @override
  // EdgeInsetsGeometry? get contentPadding => EdgeInsets.zero;
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + _headPadding),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Theme.of(context).colorScheme.outline))),
          padding: const EdgeInsets.only(bottom: _headPadding),
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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            MenuItem(
              icon: DomoIcons.star,
              title: const Text('Important'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text('Tags'),
        const SizedBox(height: 8),
        Column(
          children: [
            MenuItem(
              icon: DomoIcons.tag,
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
            ),
            MenuItem(
              icon: DomoIcons.tag,
              title: const Text('Business'),
              onTap: () {
                Navigator.pushNamed(context, '/sign-in');
              },
            ),
          ],
        )
      ],
    );
  }
}
