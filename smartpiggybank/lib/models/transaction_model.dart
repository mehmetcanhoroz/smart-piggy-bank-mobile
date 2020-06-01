import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartpiggybank/services/server_operations.dart';

class TransactionModel {
  dynamic user;
  dynamic coins;
  String createdAt;
  int unknownItemCount;
  double value;
  bool isSuccess;

  TransactionModel({
    this.user,
    this.coins,
    this.createdAt,
    this.isSuccess,
    this.value,
    this.unknownItemCount,
  });
}

class TransactionList {
  dynamic _data;

  Future<List> getTransactions() async {
    ServerOperations serverOperations = ServerOperations();
    http.Response response = await serverOperations.getTransactions();
    _data = jsonDecode(response.body);
    print('Transaction Response Data');
    print('Transaction data => ' + _data.toString());
    List<TransactionModel> list = [];

    for (var item in _data) {
//      print('user name test => ' + item['user']['name']);
      list.add(
        TransactionModel(
          user: item['user'],
          coins: item['coins'],
          isSuccess: item['is_success'],
          createdAt: item['created_at'].toString().substring(0, 10),
          value: double.parse(item['value'].toString()),
          unknownItemCount: item['unknown_item_count'],
        ),
      );
    }
    return list;
  }
}
