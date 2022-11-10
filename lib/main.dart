import 'package:domo/edit_view.dart';
import 'package:flutter/material.dart';
import 'package:domo/sign_up_page.dart';
import 'package:domo/calendar_view.dart';
import 'package:domo/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData currentThemeData = Theme.of(context);
    return MaterialApp(
      title: 'Domo',
      theme: ThemeData(
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
          outline: const Color.fromRGBO(237, 237, 237, 1)
        ),
        textTheme: currentThemeData.textTheme.copyWith(
          headline2: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700)
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )
        ),
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
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const CalendarView(title: 'All'),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/edit': (context) => const EditView(),
      },
    );
  }
}
