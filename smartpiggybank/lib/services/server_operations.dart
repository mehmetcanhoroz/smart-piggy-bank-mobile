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

  Future<dynamic> register(String name, String email, String password) async {
    NetworkHelper networkHelper = NetworkHelper(registerPath);

    var data = await networkHelper.postRegisterData(name, email, password);
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

  Future<dynamic> getTransactionProofs() async {
    NetworkHelper networkHelper = NetworkHelper(transactionProofsPath);

    var data = await networkHelper.getDataAuth();
    print(data);
    return data;
  }

  Future<dynamic> getWishlists() async {
    NetworkHelper networkHelper = NetworkHelper(wishlistsPath);

    var data = await networkHelper.getDataAuth();
    print(data);
    return data;
  }

  Future<bool> checkIamAuthorized() async {
    NetworkHelper networkHelper = NetworkHelper(dashboardPath);

    var response = await networkHelper.getDataAuth();
    print(response.statusCode);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
