import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'dart:convert';

import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';


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


  static getAddresses()async{

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-addresses/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"]['data'];

    }
    else{
      _data = [];
    }

    return _data;
  }


  static getCartData()async{

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-cart/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });
    if(response.statusCode < 206){

      _data = json.decode(response.body)["data"]['data'];


    }
    else{
      _data = [];
    }

    return _data;
  }


  static getWishListData()async{

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-addresses/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"]['data'];

    }
    else{
      _data = [];
    }

    return _data;
  }


  static getEventCat()async{

    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-event-categories"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];


    }
    else{
      _data = [];
    }

    return _data;
  }

  static getAllBusiness()async{

    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/business-types"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];


    }
    else{
      _data = [];
    }

    return _data;
  }


  static getAllEvent()async{

    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-events"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];

    }
    else{
      _data = [];
    }

    return _data;
  }
  static getAllBuses()async{

    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-routes"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];

    }
    else{
      _data = [];
    }

    return _data;
  }

  static getDestinations()async{

    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-destinations"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }


  static getOrders()async{

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-orders/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }

  static getPlacedOrders()async{

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-requests/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });

    if(response.statusCode < 206){
      try{
        _data = json.decode(response.body)["data"];
      }
      catch(e){
        _data = [];
      }

    }
    else{
      _data = [];
    }

    return _data;
  }

  static getAuction()async{

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-auctions/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });

    if(response.statusCode < 206){
      try{
        _data = json.decode(response.body)["data"];
      }
      catch(e){
        _data = [];
      }

    }
    else{
      _data = [];
    }

    return _data;
  }

  static getConfig()async{

    Map _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-configs"));
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = {};
    }

    return _data;
  }

  static getUserDetail()async{
    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    Map _data;
    http.Response response = await http.get(Uri.parse(base_url+"user/get-user/$userId"), headers: {
      HttpHeaders.authorizationHeader :"Bearer $userToken"
    });
    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = {};
    }

    return _data;
  }


  static getRegions()async{

    Region _data;
    http.Response response = await http.get(Uri.parse(base_url+"general/get-regions"));
    if(response.statusCode < 206){
      _data = Region.fromJson(json.decode(response.body));
    }
    else{
    }

    return _data;
  }



}