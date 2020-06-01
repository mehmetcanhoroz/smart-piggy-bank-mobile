import 'package:flutter/material.dart';
import 'package:smartpiggybank/screens/home_screen.dart';
import 'package:smartpiggybank/screens/transactions_page.dart';
import 'package:smartpiggybank/screens/users_page.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Homepage'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Transactions'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionsPage(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Transaction Proofs'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Users'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsersPage(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
//              Navigator.of(context).pop();
//              Navigator.pushReplacementNamed(context, '/login');

              Navigator.pushNamedAndRemoveUntil(
                  context, "/welcome", (r) => false);
            },
          ),
        ],
      ),
    );
  }
}
