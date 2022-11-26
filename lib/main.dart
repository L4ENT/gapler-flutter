import 'package:domo/isar/shortcuts.dart';
import 'package:domo/seed/main_seed.dart';
import 'package:domo/views/tags_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domo/views/edit_view.dart';
import 'package:domo/views/sign_up_view.dart';
import 'package:domo/views/calendar_view.dart';
import 'package:domo/views/sign_in_view.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

var uuidLib = const Uuid();

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const CalendarView(
          title: 'All',
          groupKeyPrefix: 'days',
        );
      },
    ),
    GoRoute(
      path: '/important',
      builder: (BuildContext context, GoRouterState state) {
        return const CalendarView(
          title: 'Important',
          groupKeyPrefix: 'days',
        );
      },
    ),
    GoRoute(
      path: '/calendar/tag/:uuid/:title',
      builder: (BuildContext context, GoRouterState state) {
        String? title = state.params['title'];
        title ??= 'title';

        String? uuid = state.params['uuid'];
        uuid ??= 'uuid';

        return CalendarView(
          key: Key('calendar_view:$title:$uuid'),
          title: title,
          groupKeyPrefix: 'days',
        );
      },
    ),
    GoRoute(
      path: '/sign-in',
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
    ),
    GoRoute(
      path: '/sign-up',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpPage();
      },
    ),
    GoRoute(
      path: '/edit/tags',
      builder: (BuildContext context, GoRouterState state) {
        return const EditNoteTagsView();
      },
    ),
    GoRoute(
      path: '/edit',
      builder: (BuildContext context, GoRouterState state) {
        String uuid = uuidLib.v4();
        return EditView(uuid: uuid);
      },
    ),
    GoRoute(
      path: '/edit/:uuid',
      builder: (BuildContext context, GoRouterState state) {
        String? uuid = state.params['uuid'];
        uuid ??= uuidLib.v4();
        return EditView(uuid: uuid);
      },
    ),
    GoRoute(
      path: '/tags',
      builder: (BuildContext context, GoRouterState state) {
        return const TagsView();
      },
    ),
  ],
);

void main() async {
  // final isar = await isarOpen();
  // await mainSeed(isar);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData currentThemeData = Theme.of(context);
    return MaterialApp.router(
        title: 'Domo', theme: _customTheme(context), routerConfig: _router
        // initialRoute: '/',
        // routes: {
        //   // When navigating to the "/" route, build the FirstScreen widget.
        //   '/': (context) => const CalendarView(title: 'All', groupKeyPrefix: 'days',),
        //   '/sign-in': (context) => const SignInPage(),
        //   '/sign-up': (context) => const SignUpPage(),
        //   '/edit': (context) => const EditView(),
        // },
        );
  }

  ThemeData _customTheme(BuildContext context) {
    ThemeData currentThemeData = Theme.of(context);
    return ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      fontFamily: 'Nunito',
      colorScheme: currentThemeData.colorScheme.copyWith(
          brightness: Brightness.light,
          primary: const Color.fromRGBO(203, 27, 115, 1),
          onPrimary: Colors.white,
          surface: const Color.fromRGBO(249, 249, 249, 1),
          outline: const Color.fromRGBO(237, 237, 237, 1)),
      textTheme: currentThemeData.textTheme.copyWith(
          headline2:
              const TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      )),
      appBarTheme: currentThemeData.appBarTheme.copyWith(
          color: const Color.fromRGBO(249, 249, 249, 1),
          foregroundColor: const Color.fromRGBO(53, 53, 53, 1),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: Color.fromRGBO(53, 53, 53, 1), fontSize: 14),
          elevation: 0,
          shape: const Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromRGBO(234, 234, 234, 1)))),
      scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      primaryColor: const Color.fromRGBO(203, 27, 115, 1),
      // primarySwatch: Colors.grey,
    );
  }
}
