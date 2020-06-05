import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smartpiggybank/models/wishlist_model.dart';
import 'package:smartpiggybank/theme/light_color.dart';
import 'package:smartpiggybank/theme/theme.dart';
import 'package:smartpiggybank/widgets/nav_drawer.dart';
import 'package:smartpiggybank/widgets/piggybank_app_bar.dart';

class WishlistsPage extends StatefulWidget {
  @override
  _WishlistsPageState createState() => _WishlistsPageState();
}

class _WishlistsPageState extends State<WishlistsPage> {
  bool _isLoading = true;
  var width;

  @override
  void initState() {
    super.initState();
    this.prepareWishlistListForView();
  }

  Future<void> refreshWishlistList() async {
    this.prepareWishlistListForView();
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
          appBarTitle: Text('Wishlists'),
        ),
        body: RefreshIndicator(
          onRefresh: refreshWishlistList,
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

  List<Widget> prepareWishlistListForWidget() {
    List<Widget> list = List<Widget>();

    if (this.uList == null) {
      setState(() {
        this.uList = [];
      });
    }
    if (this.uList.length == 0)
      return <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'No data',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
            ),
          ],
        ),
      ];

    for (var item in this.uList) {
      list.add(
        _courceInfo(item, _decorationContainerA(Colors.redAccent, -110, -85),
            background: item.isDone ? LightColor.seeBlue : LightColor.purple),
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

  List<WishlistModel> uList;

  Future<void> prepareWishlistListForView() async {
//    sleep(Duration(seconds: 3));
    setState(() {
      _isLoading = true;
    });
    WishlistList wishlistList = WishlistList();
    List<WishlistModel> uList = await wishlistList.getWishlists();

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
          children: prepareWishlistListForWidget(),
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
      return Icon(FontAwesomeIcons.check, color: LightColor.green);
    } else {
      return Icon(FontAwesomeIcons.clock, color: Colors.amber);
    }
  }

  Widget _courceInfo(WishlistModel model, Widget decoration,
      {Color background}) {
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 20,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                            child: Text('Wishlist: ${model.name}',
                                style: TextStyle(
                                    color: LightColor.purple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          statusIcon(model.isDone),
                          SizedBox(
                            width: 5,
                          ),
                          Text(model.isDone ? 'Done' : 'Progress',
                              style: TextStyle(
                                color: LightColor.grey,
                                fontSize: 14,
                              )),
                          SizedBox(width: 10)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Current: ${model.current}TL',
                          textAlign: TextAlign.left,
                          style: AppTheme.h6Style.copyWith(
                            fontSize: 12,
                            color: LightColor.grey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Goal: ${model.goal}TL',
                          textAlign: TextAlign.right,
                          style: AppTheme.h6Style.copyWith(
                            fontSize: 12,
                            color: LightColor.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: new LinearPercentIndicator(
                          width: width - 100,
                          animation: true,
                          alignment: MainAxisAlignment.center,
                          animationDuration: 1000,
                          lineHeight: 20.0,
                          percent:
                              model.isDone ? 1 : (model.current / model.goal),
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: model.isDone
                              ? LightColor.green
                              : Colors.amberAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ))
            ],
          ),
          /*Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: coinImages(model),
          )*/
        ],
      ),
    );
  }
}
