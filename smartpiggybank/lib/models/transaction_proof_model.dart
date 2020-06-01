import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartpiggybank/services/server_operations.dart';

class TransactionProofModel {
  dynamic transaction;
  String image;

  TransactionProofModel({
    this.transaction,
    this.image,
  });
}

class TransactionProofList {
  dynamic _data;

  Future<List> getTransactionProofs() async {
    ServerOperations serverOperations = ServerOperations();
    http.Response response = await serverOperations.getTransactionProofs();
    _data = jsonDecode(response.body);
    print('Transaction Proof Response Data');
    print('Transaction proof data => ' + _data.toString());
    List<TransactionProofModel> list = [];

    for (var item in _data) {
//      print('user name test => ' + item['user']['name']);
      list.add(
        TransactionProofModel(
          image: item['image'],
          transaction: item['transaction'],
        ),
      );
    }
    return list;
  }
}
