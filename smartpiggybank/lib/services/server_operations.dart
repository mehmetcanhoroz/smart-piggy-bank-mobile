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

  Future<dynamic> getDashboardDetails() async {
    NetworkHelper networkHelper = NetworkHelper(dashboardPath);

    var data = await networkHelper.getDashboardData();
    print(data);
    return data;
  }

  Future<dynamic> getTransactions() async {
    NetworkHelper networkHelper = NetworkHelper(transactionsPath);

    var data = await networkHelper.getDataAuth();
    print(data);
    return data;
  }
}
