import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'package:yaru/yaru.dart' as yaru;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var theme = yaru.lightTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      theme: theme,
      home: HomePage(
          themeChanged: (themeName) => setState(() {
                if (themeName == 'Yaru-light') {
                  theme = yaru.lightTheme;
                } else if (themeName == 'Yaru-dark') {
                  theme = yaru.darkTheme;
                }
              })),
    );
  }
}
