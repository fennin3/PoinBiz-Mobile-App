import 'package:shared_preferences/shared_preferences.dart';

class UserData{

  static getUserId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getStringList("data")[1];

    return userId;
  }

  static getUserToken()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userToken = sharedPreferences.getStringList("data")[0];

    return userToken;
  }
}