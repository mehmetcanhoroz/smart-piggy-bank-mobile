import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpiggybank/services/server_operations.dart';
import 'package:smartpiggybank/theme/extention.dart';
import 'package:smartpiggybank/theme/light_color.dart';
import 'package:smartpiggybank/theme/text_styles.dart';
import 'package:smartpiggybank/theme/theme.dart';
import 'package:smartpiggybank/widgets/nav_drawer.dart';
import 'package:smartpiggybank/widgets/piggybank_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  bool _isLoading = true;
  String _name = '';
  String _gUserCount = '0';
  String _gTransactionCount = '0';
  String _gCalendarCount = '0';
  String _gTotalSaving = '0';
  String _uTransactionCount = '0';
  String _uWeeklyTransaction = '0';
  String _uCoinCount = '0';
  String _uTotalSaving = '0';

  welcomePageNetwork() async {
    ServerOperations serverOperations = ServerOperations();
    http.Response response = await serverOperations.getDashboardDetails();
    var data;

    if (response != null) {
      data = jsonDecode(response.body);
      print('Response is not null');
      if (response.statusCode == 200) {
        print('Response 200');
        print(data);
        SharedPreferences prefs = await SharedPreferences.getInstance();
//        await prefs.setString('password', _password);

        setState(() {
          _isLoading = false;

          this._name = prefs.getString('name');
          this._gUserCount = data['global']['userCount'].toString();
          this._gTransactionCount =
              data['global']['transactionCount'].toString();
          this._gCalendarCount = data['global']['calendarCount'].toString();
          this._gTotalSaving = data['global']['totalSaving'].toString();
          this._uTransactionCount = data['user']['transactionCount'].toString();
          this._uWeeklyTransaction =
              data['user']['weeklyTransaction'].toString();
          this._uCoinCount = data['user']['coinCount'].toString();
          this._uTotalSaving = data['user']['totalSaving'].toString();
        });
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print('ERROR DASHBOARD DETAILS');
        print('Response Error');
        print(data);
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Error"),
              content: new Text(
                  'We got an error while getting dashboard details. Please re-login!'),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/welcome", (r) => false);
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      print('response is null');
    }
  }

  Future<void> refreshDashboardDetails() async {
    setState(() {
      _isLoading = true;
    });
    this.welcomePageNetwork();
  }

  @override
  void initState() {
    super.initState();
    welcomePageNetwork();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        key: _key,
        // set it here
        drawer: NavDrawer(),
//      endDrawer: NavDrawer(),
        /*appBar: AppBar(
          title: Text('Smart Piggybank'),
        ),*/
        appBar: PiggyBankAppBar(
          appBarTitle: Text('Smart Piggy Bank'),
          context: context,
          parentKey: _key,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: RefreshIndicator(
          onRefresh: refreshDashboardDetails,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  _header(),
                  _category(
                      categoryTitle: 'Smart Piggy Bank Stats',
                      categoryItems: _piggyBankStatsList()),
                  _category(
                      categoryTitle: 'Your Stats',
                      categoryItems: _piggyBankUserStatsList()),
                ]),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            refreshDashboardDetails();
          },
          tooltip: 'Refresh Dashboard Details',
          child: Icon(Icons.refresh),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text(this._name, style: TextStyles.h1Style),
      ],
    ).p16;
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(
          Icons.short_text,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () {
          _key.currentState.openDrawer(); // this opens drawer
        },
      ),
      actions: <Widget>[
        Icon(
          Icons.notifications_none,
          size: 30,
          color: LightColor.grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//          child: ClipRRect(
          child: ClipOval(
//            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              // height: 40,
              // width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).backgroundColor,
              ),
              child: Image.asset("assets/user.png", fit: BoxFit.fitWidth),
            ),
          ),
        ),
      ],
    );
  }

  Widget _category({String categoryTitle, List<Widget> categoryItems}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(categoryTitle, style: TextStyles.title.bold),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categoryItems,
          ),
        ),
      ],
    );
  }

  List<Widget> _piggyBankStatsList() {
    return <Widget>[
      _categoryCard(this._gTransactionCount, "Transaction Count",
          FontAwesomeIcons.dollarSign,
          color: LightColor.green, lightColor: LightColor.lightGreen),
      _categoryCard(
          this._gCalendarCount, "Today Transactions", FontAwesomeIcons.chartBar,
          color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
      _categoryCard(
          this._gUserCount, "Registered User", FontAwesomeIcons.userPlus,
          color: LightColor.orange, lightColor: LightColor.lightOrange),
      _categoryCard("${this._gTotalSaving} TL", "Total Money Saving",
          FontAwesomeIcons.liraSign,
          color: LightColor.purple, lightColor: LightColor.purpleLight),
    ];
  }

  List<Widget> _piggyBankUserStatsList() {
    return <Widget>[
      _categoryCard(
          this._uTransactionCount, "Transaction Count", FontAwesomeIcons.coins,
          color: LightColor.green, lightColor: LightColor.lightGreen),
      _categoryCard(this._uWeeklyTransaction, "Weekly Transactions",
          FontAwesomeIcons.chartBar,
          color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
      _categoryCard(
          this._uCoinCount, "Dropped Coin Count", FontAwesomeIcons.coins,
          color: LightColor.orange, lightColor: LightColor.lightOrange),
      _categoryCard("${this._uTotalSaving} TL", "Your Total Saving",
          FontAwesomeIcons.liraSign,
          color: LightColor.purple, lightColor: LightColor.purpleLight),
    ];
  }

  Widget _categoryCard(String title, String subtitle, IconData cardIcon,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Icon(
                        cardIcon,
                        color: Colors.white,
                        size: 68,
                      ),
                    ),
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ),
      ),
    );
  }
}
