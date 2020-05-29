import 'package:smartpiggybank/services/networking.dart';

class ServerOperations {
  Future<dynamic> getUsers() async {
    NetworkHelper networkHelper = NetworkHelper(getUsersPath);

    var data = await networkHelper.getData();
    print(data);
    return data;
  }

  Future<dynamic> login(String email, String password) async {
    NetworkHelper networkHelper = NetworkHelper(loginPath);

    var data = await networkHelper.postLoginData(email, password);
    print(data);
    return data;
  }
}
