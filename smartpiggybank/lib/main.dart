import 'package:flutter/material.dart';
import 'package:smartpiggybank/screens/home_screen.dart';
import 'package:smartpiggybank/screens/login_page.dart';
import 'package:smartpiggybank/screens/transaction_proofs_page.dart';
import 'package:smartpiggybank/screens/transactions_page.dart';
import 'package:smartpiggybank/screens/users_page.dart';
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
//      home: WelcomePage(),
//      home: WelcomePage(),
      //title: 'Flutter Demo Home Page'
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => WelcomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/users': (context) => UsersPage(),
        '/welcome': (context) => WelcomePage(),
        '/transactions': (context) => TransactionsPage(),
        '/transaction_proofs': (context) => TransactionProofsPage(),
      },
    );
  }
}
