import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartpiggybank/services/server_operations.dart';

class WishlistModel {
  String name;
  double goal;
  double current;
  bool isDone;

  WishlistModel({
    this.name,
    this.goal,
    this.current,
    this.isDone,
  });
}

class WishlistList {
  dynamic _data;

  Future<List> getWishlists() async {
    ServerOperations serverOperations = ServerOperations();
    http.Response response = await serverOperations.getWishlists();
    _data = jsonDecode(response.body);
    print('Wishlists Response Data');
    print('Wishlists data => ' + _data.toString());
    List<WishlistModel> list = [];

    for (var item in _data) {
//      print('user name test => ' + item['user']['name']);
      list.add(
        WishlistModel(
          name: item['name'],
          goal: double.parse(item['goal'].toString()),
          current: double.parse(item['current'].toString()),
          isDone: item['is_done'],
        ),
      );
    }
    return list;
  }
}
