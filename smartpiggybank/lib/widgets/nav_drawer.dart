import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpiggybank/screens/home_screen.dart';
import 'package:smartpiggybank/screens/leaderboard_page.dart';
import 'package:smartpiggybank/screens/statistics_page.dart';
import 'package:smartpiggybank/screens/transaction_proofs_page.dart';
import 'package:smartpiggybank/screens/transactions_page.dart';
import 'package:smartpiggybank/screens/users_page.dart';
import 'package:smartpiggybank/screens/wishlists_page.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
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
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionProofsPage(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.listAlt),
            title: Text('Leaderboard'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaderboardPage(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.wallet),
            title: Text('Wishlists'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistsPage(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.chartBar),
            title: Text('Statistics'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticsPage(),
                ),
              ),
            },
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
            onTap: () async {
//              Navigator.of(context).pop();
//              Navigator.pushReplacementNamed(context, '/login');

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('token');
              Navigator.pushNamedAndRemoveUntil(
                  context, "/welcome", (r) => false);
            },
          ),
        ],
      ),
    );
  }
}
