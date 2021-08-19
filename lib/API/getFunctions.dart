import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:treva_shop_flutter/constant.dart';


class GetFunc{
  static getCategories()async{
    List _data;
    try{
      http.Response response = await http.get(Uri.parse(base_url+"general/get-categories"));

      if(response.statusCode < 206){
        _data = json.decode(response.body)["data"];
      }
      else{
        _data = [];
      }

      return _data;
    }
    on SocketException{
      EasyLoading.showInfo("No Internet");
    }
  }


  static getBanners()async{
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/banners/"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }


  static getPromos()async{
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/promotions/"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }


  static getProducts()async{
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-products"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }


}