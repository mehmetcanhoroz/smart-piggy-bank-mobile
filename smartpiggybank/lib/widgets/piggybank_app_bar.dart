import 'package:flutter/material.dart';
import 'package:smartpiggybank/theme/light_color.dart';

class PiggyBankAppBar extends AppBar {
/*
* AppBar(
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
    );*/

  PiggyBankAppBar(
      {Key key,
      @required Widget appBarTitle,
      @required BuildContext context,
      @required GlobalKey<ScaffoldState> parentKey})
      : super(
          key: key,
          title: appBarTitle,
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
              parentKey.currentState.openDrawer(); // this opens drawer
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
