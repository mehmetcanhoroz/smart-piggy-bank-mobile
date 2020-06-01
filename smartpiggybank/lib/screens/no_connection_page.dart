import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.timesCircle,
                color: Colors.red,
                size: 144,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'You don\'t have network connection!',
                style: TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25,),
              FlatButton(
                color: Colors.blueGrey,
                onPressed: () {
                  //TODO go welcome page with clear stack
                },
                child: Text(
                  'Try to connect again',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
