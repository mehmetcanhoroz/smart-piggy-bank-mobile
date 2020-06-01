import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smartpiggybank/models/user_model.dart';
import 'package:smartpiggybank/theme/light_color.dart';
import 'package:smartpiggybank/theme/theme.dart';
import 'package:smartpiggybank/widgets/nav_drawer.dart';
import 'package:smartpiggybank/widgets/piggybank_app_bar.dart';
import 'package:smartpiggybank/widgets/quad_clipper.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool _isLoading = true;
  var width;

  @override
  void initState() {
    super.initState();
    this.prepareUserListForView();
  }

  Future<void> refreshUsersList() async {
    this.prepareUserListForView();
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
          appBarTitle: Text('Users'),
        ),
        body: RefreshIndicator(
          onRefresh: refreshUsersList,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _courseList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> prepareUserListForWidget() {
    List<Widget> list = List<Widget>();

    if (this.uList == null) {
      setState(() {
        this.uList = [];
      });
    }

    for (var item in this.uList) {
      list.add(
        _courceInfo(item, _decorationContainerA(Colors.redAccent, -110, -85),
            background: item.isParent ? LightColor.seeBlue : LightColor.purple),
      );
      list.add(
        Divider(
          thickness: 1,
          endIndent: 20,
          indent: 20,
        ),
      );
    }
    return list;
  }

  List<UserModel> uList;

  Future<void> prepareUserListForView() async {
//    sleep(Duration(seconds: 3));
    setState(() {
      _isLoading = true;
    });
    UserList userList = UserList();
    List<UserModel> uList = await userList.getUsers();

    setState(() {
      this.uList = uList;
      this._isLoading = false;
    });
  }

  Widget _courseList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: prepareUserListForWidget(),
        ),
      ),
    );
  }

  Widget _decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
                CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainerC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _courceInfo(UserModel model, Widget decoration, {Color background}) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: width - 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              model.isParent ? 'assets/user.png' : 'assets/child.png',
              width: 75,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(model.name,
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: background,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.isParent ? 'Parent' : 'Child',
                          style: TextStyle(
                            color: LightColor.grey,
                            fontSize: 14,
                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      model.email,
                      textAlign: TextAlign.left,
                      style: AppTheme.h6Style.copyWith(
                        fontSize: 12,
                        color: LightColor.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    _chip('${model.coinCount} coins', LightColor.darkOrange,
                        height: 5),
                    SizedBox(
                      width: 5,
                    ),
                    _chip('${model.transactionCount} transactions',
                        LightColor.seeBlue,
                        height: 5),
                    SizedBox(
                      width: 5,
                    ),
                    _chip(
                        '${model.totalSaving}TL saving', LightColor.purpleLight,
                        height: 5),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 9),
      ),
    );
  }
}
