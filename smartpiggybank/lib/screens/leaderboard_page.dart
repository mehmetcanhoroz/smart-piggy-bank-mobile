import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smartpiggybank/widgets/nav_drawer.dart';
import 'package:smartpiggybank/widgets/piggybank_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool _isLoading = false;
  var width;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        key: _key,
        drawer: NavDrawer(),
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PiggyBankAppBar(
          parentKey: _key,
          context: context,
          appBarTitle: Text('Leaderboard'),
        ),
        body: RefreshIndicator(
          onRefresh: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'http://165.22.64.40/api/leaderboard?mobile=1',
            ),
          ),
        ),
      ),
    );
  }
}
