import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String getUsersPath = 'users';
const String loginPath = 'login';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  final String _serverAddress = "http://165.22.64.40/api/";

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token');
    print('Token getdata $token');

    http.Response response = await http.get(
      _serverAddress + url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      String dataS = response.body;
      var data = jsonDecode(dataS);
      return data;
    } else {
      print('Error Request');
      print('response:' + response.toString());
      print('status code:' + response.statusCode.toString());
    }
  }

  Future postLoginData(String email, String password) async {
    http.Response response = await http.post(
      _serverAddress + url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      String dataS = response.body;
      var data = jsonDecode(dataS);
    } else {
      print('Error Request');
      print('response:' + response.body.toString());
      print('status code:' + response.statusCode.toString());
    }
    return response;
  }
}
