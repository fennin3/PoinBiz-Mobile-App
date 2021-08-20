import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/getFunctions.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'dart:math';
import 'package:treva_shop_flutter/utils.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();


bool aaV (String a){
  return a.toLowerCase() == "true";
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class PoinBizProvider with ChangeNotifier {
  List allcategories;
  List allbanners = [];
  List allpromos = [];
  List allProducts = [];
  List addresses = [];
  List alleventCat = [];
  List allevents = [];
  List<Address> saveAdds = [];
  bool loading;
  Address shipping;
  List<CartModel> cart = [];
  List<SearchedWord> searchedWords = [];
  int totalPrice = 0;

  ///Cart
  addToCart(Map item, _key) async {
    EasyLoading.show(status: "Updating cart");
    final imageName = getRandomString(10);

    await MyUtils.downloadAndSaveImage(item['image'], imageName);
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    var box = await Hive.openBox<CartModel>('cart');

    final _item = CartModel(
        quantity: item['quantity'],
        price: item['price'],
        image: documentDirectory.path + "/" + imageName + ".png",
        title: item['title']);
    box.add(_item);
    getCartItem();
    var snackbar = SnackBar(
      content: Text("Item Added"),
    );
    EasyLoading.dismiss();
    _key.currentState.showSnackBar(snackbar);

    notifyListeners();
  }

  getCartItem() async {
    final box = await Hive.openBox<CartModel>('cart');

    cart = box.values.toList();

    notifyListeners();
  }

  void updateAddItem(CartModel _item) {
    final nu = int.parse(_item.quantity) + 1;
    _item.quantity = nu.toString();
    getCartItem();
  }

  void updateSubItem(CartModel _item) async {
    if (int.parse(_item.quantity) > 1) {
      final nu = int.parse(_item.quantity) - 1;
      _item.quantity = nu.toString();
    } else {
      var box = await Hive.openBox<CartModel>('cart');
      box.deleteAt(cart.indexOf(_item));
    }

    getCartItem();
  }

  String getTotal() {
    totalPrice = 0;
    for (var item in cart) {
      totalPrice += int.parse(item.price) * int.parse(item.quantity);
    }

    return totalPrice.toString();
  }

  void removeCartItem(CartModel _item) async {
    var box = await Hive.openBox<CartModel>('cart');
    box.deleteAt(cart.indexOf(_item));

    getCartItem();
  }

  ///End of Cart

  ///Searched Words

  saveWord(String _word) async {
    var box = await Hive.openBox<SearchedWord>('searched');

    final _item = SearchedWord(text: _word);

    box.add(_item);
    getSearchwords();
    notifyListeners();
  }

  getSearchwords() async {
    final box = await Hive.openBox<SearchedWord>('searched');

    searchedWords = box.values.toList().reversed.toList();

    notifyListeners();
  }

  ///End of Searched Words

  ///Shipping Addresses
  addAddress(Map item, _key) async {

    var box = await Hive.openBox<Address>('address');

    saveAdds = box.values.toList().reversed.toList();
    int exists = 0;

    final _item = Address(
        address: item['address'],
        name: item['name'],
        phone: item['phone'],
        postal: item['postal'],
        recipient: item['recipient'],
        defaultt: aaV(item['default']));

    saveAdds = box.values.toList().reversed.toList();

    for(var i in saveAdds){
      if (i.name.toString().toLowerCase() == _item.name.toString().toLowerCase()){
        exists += 1;

      }
      else{

      }
    }
    if(exists < 1){
      box.add(_item);
    }

    var snackbar = SnackBar(
      content: Text("Address Saved"),
    );

    if(_key != "aa")
    _key.currentState.showSnackBar(snackbar);

    getAdds();

    notifyListeners();
  }

  getAdds() async {
    final box = await Hive.openBox<Address>('address');

    saveAdds = box.values.toList().reversed.toList();

    notifyListeners();
  }

  // deletefromDisk()async{
  //   final box = await Hive.openBox<Address>('address');
  //   // final box1 = await Hive.openBox<CartModel>('cart');
  //   // final box2 = await Hive.openBox<SearchedWord>('searched');
  //   box.deleteFromDisk();
  //   // box1.deleteFromDisk();
  //   // box2.deleteFromDisk();
  //
  //   print("deleted");
  //
  // }

  void sendAddress(Map item, _key) async {
    addAddress(item, _key);


    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _adds = [];

    for (var add in saveAdds) {
      _adds.add(
        {
          "name": add.name.toString(),
          "address": add.address.toString(),
          "postal": add.postal.toString(),
          "phone": add.phone.toString(),
          "recipient": add.recipient.toString(),
          "default": add.defaultt.toString()
        }
      );
    }



    final _data = {"user_id": user_id, "addresses": json.encode(_adds)};

    try{
      http.Response response = await http.post(
        Uri.parse(base_url + "user/address-process"),
        body: _data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $user_token",
        },
      );
    }
    on SocketException{
      EasyLoading.showInfo("No internet connection");
    }

  }

  void updateAddress(Address add, Map _item) async{
    add.defaultt = _item['default'];
    add.recipient = _item['recipient'];
    add.phone = _item['phone'];
    add.address = _item['address'];
    add.name = _item['name'];

    getAdds();

    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _adds = [];

    for (var add in saveAdds) {
      _adds.add({
        {
          "name": add.name,
          "address": add.address,
          "postal": add.postal,
          "phone": add.phone,
          "recipient": add.recipient,
          "default": add.defaultt
        }
      });
    }

    final _data = {"user_id": user_id, "addresses": json.encode(_adds)};

    try{
      http.Response response = await http.post(
        Uri.parse(base_url + "user/address-process"),
        body: _data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $user_token",
        },
      );
    }
    on SocketException{
      EasyLoading.showInfo("No internet connection");
    }

  }

  void deleteAddress(Address add)async{
    var box = await Hive.openBox<Address>('address');
    box.deleteAt(saveAdds.indexOf(add));
    getAdds();

    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _adds = [];

    for (var add in saveAdds) {
      _adds.add({
        {
          "name": add.name,
          "address": add.address,
          "postal": add.postal,
          "phone": add.phone,
          "recipient": add.recipient,
          "default": add.defaultt
        }
      });
    }

    final _data = {"user_id": user_id, "addresses": json.encode(_adds)};

    try{
      http.Response response = await http.post(
        Uri.parse(base_url + "user/address-process"),
        body: _data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $user_token",
        },
      );
    }
    on SocketException{
      EasyLoading.showInfo("No internet connection");
    }
  }


  ///End Shipping

  ///API Calls
  void getBanners() async {
    allbanners = await GetFunc.getBanners();

    notifyListeners();
  }

  void getPromos() async {
    allpromos = await GetFunc.getPromos();

    notifyListeners();
  }

  void getAddresses() async {
    addresses = await GetFunc.getAddresses();

    for(var item in addresses){
      addAddress(item, "aa");
    }


    notifyListeners();
  }

  void getProducts() async {
    allProducts = await GetFunc.getProducts();

    notifyListeners();
  }

  void getallCategories() async {
    allcategories = await GetFunc.getCategories();

    notifyListeners();
  }


  void getEventCategories() async {
    alleventCat = await GetFunc.getEventCat();
    notifyListeners();
  }

  void getAllEvent() async {
    allevents = await GetFunc.getAllEvent();
    notifyListeners();
  }

  void setShipping(Address data) {
    shipping = data;

    notifyListeners();
  }
}
