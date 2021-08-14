import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/getFunctions.dart';
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'dart:math';
import 'package:treva_shop_flutter/utils.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


class PoinBizProvider with ChangeNotifier{
  List allcategories;
  List allbanners=[];
  bool loading;
  List<CartModel> cart = [];
  int totalPrice = 0;



  // void addToCart2(Map item)async{
  //
  //       final imageName = getRandomString(10);
  //
  //       await MyUtils.downloadAndSaveImage(item['image'], imageName);
  //
  //       final _item = CartItem(
  //         title: item['title'],
  //         image: item['image'],
  //         price: item['price'],
  //         quantity: item['quantity'],
  //       );
  //
  //
  //
  //       cart.add(_item);
  //       totalPrice=0;
  //       notifyListeners();
  // }

  addToCart(Map item) async {

    final imageName = getRandomString(10);

    await MyUtils.downloadAndSaveImage(item['image'], imageName);
    Directory documentDirectory = await getApplicationDocumentsDirectory();


    var box = await Hive.openBox<CartModel>('cart');

    final _item = CartModel(
      quantity: item['quantity'],
      price: item['price'],
      image: documentDirectory.path + "/" + imageName + ".png" ,
      title: item['title']
    );
    box.add(_item);
    getCartItem();


    notifyListeners();
  }

  getCartItem() async {
    final box = await Hive.openBox<CartModel>('cart');

    cart = box.values.toList();

    notifyListeners();
  }

  void deleteAll()async{
    var box = await Hive.openBox<CartModel>('cart');

    // box.delete('cart');
    box.deleteFromDisk();

    getCartItem();
  }

  void updateAddItem(CartModel _item){
      final nu = int.parse(_item.quantity) + 1;
      _item.quantity = nu.toString();
      getCartItem();
  }


  void updateSubItem(CartModel _item)async{
    if(int.parse(_item.quantity) > 1){
      final nu = int.parse(_item.quantity) - 1;
      _item.quantity = nu.toString();
    }
    else{
      var box = await Hive.openBox<CartModel>('cart');
      box.deleteAt(cart.indexOf(_item));
    }

    getCartItem();
  }

  String getTotal(){
    totalPrice = 0;
    for (var item in cart) {
      totalPrice += int.parse(item.price) * int.parse(item.quantity);
    }

    return totalPrice.toString();
  }


  void removeCartItem(CartModel _item)async{
    var box = await Hive.openBox<CartModel>('cart');
    box.deleteAt(cart.indexOf(_item));

    getCartItem();
  }


  void getallCategories()async{
    allcategories = await GetFunc.getCategories();

    print(allcategories);

    notifyListeners();
  }





}