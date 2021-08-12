import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:treva_shop_flutter/constant.dart';


class GetFunc{
  static getCategories()async{
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-categories"));

    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }


}