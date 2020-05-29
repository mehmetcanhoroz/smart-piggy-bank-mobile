import 'package:flutter/material.dart';
import 'package:smartpiggybank/screens/welcome_page.dart';
import 'package:smartpiggybank/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Piggy Bank',
      theme: AppTheme.lightTheme,
      home: WelcomePage(),
//      home: WelcomePage(),
      //title: 'Flutter Demo Home Page'
    );
  }
}
