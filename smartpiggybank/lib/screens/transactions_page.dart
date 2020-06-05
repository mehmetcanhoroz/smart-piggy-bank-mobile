import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smartpiggybank/models/transaction_model.dart';
import 'package:smartpiggybank/theme/light_color.dart';
import 'package:smartpiggybank/theme/theme.dart';
import 'package:smartpiggybank/widgets/nav_drawer.dart';
import 'package:smartpiggybank/widgets/piggybank_app_bar.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  bool _isLoading = true;
  var width;

  @override
  void initState() {
    super.initState();
    this.prepareTransactionListForView();
  }

  Future<void> refreshTransactionList() async {
    this.prepareTransactionListForView();
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
          appBarTitle: Text('Transactions'),
        ),
        body: RefreshIndicator(
          onRefresh: refreshTransactionList,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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

  List<Widget> prepareTransactionListForWidget() {
    List<Widget> list = List<Widget>();

    if (this.uList == null) {
      setState(() {
        this.uList = [];
      });
    }

    for (var item in this.uList) {
      list.add(
        _courceInfo(item, _decorationContainerA(Colors.redAccent, -110, -85),
            background:
                item.isSuccess ? LightColor.seeBlue : LightColor.purple),
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

  List<TransactionModel> uList;

  Future<void> prepareTransactionListForView() async {
//    sleep(Duration(seconds: 3));
    setState(() {
      _isLoading = true;
    });
    TransactionList transactionList = TransactionList();
    List<TransactionModel> uList = await transactionList.getTransactions();

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
          children: prepareTransactionListForWidget(),
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

  Widget statusIcon(bool isSuccess) {
    if (isSuccess) {
      return Icon(FontAwesomeIcons.plus, color: LightColor.green);
    } else {
      return Icon(FontAwesomeIcons.times, color: Colors.red);
    }
  }

  Widget _courceInfo(TransactionModel model, Widget decoration,
      {Color background}) {
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 20,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      model.user['is_parent']
                          ? 'assets/user.png'
                          : 'assets/child.png',
                      width: 50,
                    ),
                  ),
                  Text(
                    model.user['name'],
                    style: TextStyle(
                      color: LightColor.darkgrey,
                      fontSize: 14,
                    ),
                  ),
                ],
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
                            child: Text(
                                'Id = ${model.id} - Saving: ' +
                                    model.value.toString() +
                                    ' TL',
                                style: TextStyle(
                                    color: LightColor.purple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          statusIcon(model.isSuccess),
                          SizedBox(
                            width: 5,
                          ),
                          Text(model.isSuccess ? 'Success' : 'Failed',
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
                          'Date: ' + model.createdAt,
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
                  ],
                ),
              ))
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: coinImages(model),
          )
        ],
      ),
    );
  }

  List<Widget> coinImages(model) {
    print('Coin test =>' + model.toString());
    List<Widget> list = [];

    for (var item in model.coins) {
      var name = '';
      name = (item['value'] * 100).toInt().toString();
      print('Coin name => ' + name);
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            'assets/coins/${name.toString()}.png',
            height: 50,
          ),
        ),
      );
    }
    for (var i = 1; i <= model.unknownItemCount; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            'assets/coins/unknown.png',
            height: 50,
          ),
        ),
      );
    }
    return list;
  }
}
