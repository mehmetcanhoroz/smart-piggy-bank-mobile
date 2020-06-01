import 'dart:convert';

import 'package:smartpiggybank/services/server_operations.dart';
import 'package:http/http.dart' as http;

class UserModel {
  String name;
  String email;
  bool isParent;
  int transactionCount;
  int coinCount;
  double totalSaving;

  UserModel({
    this.name,
    this.email,
    this.isParent,
    this.transactionCount,
    this.coinCount,
    this.totalSaving,
  });
}

class UserList {
  dynamic _data;

  Future<List> getUsers() async {
    ServerOperations serverOperations = ServerOperations();
    http.Response response = await serverOperations.getUsers();
    _data = jsonDecode(response.body);
        print(_data);
    List<UserModel> list = [];

    for (var item in _data) {
      list.add(
        UserModel(
          name: item['name'],
          email: item['email'],
          isParent: item['is_parent'],
          transactionCount: item['transactions_count'],
          coinCount: item['coins_count'],
          totalSaving: double.parse(item['total_saving'].toString()),
        ),
      );
    }
    return list;
  }
}
