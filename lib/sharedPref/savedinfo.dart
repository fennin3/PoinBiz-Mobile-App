import 'package:shared_preferences/shared_preferences.dart';

class UserData{

  static getUserId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId;
    try{
      userId = sharedPreferences.getStringList("data")[1].toString();
    }
    catch(e){}


    return userId;
  }

  static getUserToken()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userToken;
    try{
      userToken = sharedPreferences.getStringList("data")[0];
    }
    catch(e){

    }

    return userToken;
  }
}