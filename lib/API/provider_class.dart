import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/getFunctions.dart';
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

bool aaV(String a) {
  bool z = a.toLowerCase() == "true";
  return z;
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class PoinBizProvider with ChangeNotifier {
  List allcategories;
  List allbanners = [];
  List allpromos = [];
  List allProducts = [];
  Map config={};
  Map userDetail={};
  List alleventCat = [];
  List allBusinessType = [];
  List alldestinations = [];
  List allorders = [];
  List allbuses = [];
  List allevents = [];
  List<Address> saveAdds = [];
  bool loading;
  Address shipping = Address();
  List<CartModel> cart = [];
  List<SearchedWord> searchedWords = [];
  List<WishItem> wishlist = [];
  int totalPrice = 0;
  List placedOrders=[];
  List auctions=[];
  Region regions;

  ///Cart
  addToCart(Map item, _key, how) async {
    if(how!='online')
      EasyLoading.show(status: "Updating cart");
    // final imageName = getRandomString(10);
    Directory documentDirectory;

    var box = await Hive.openBox<CartModel>('cart');

    final _item = CartModel(
        quantity: item['quantity'],
        price: item['price'],
        image: item['image'] != "ticket" ? item['image'] : "ticket",
        title: item['title'],
        color: item['color'],
        id: item['id'].toString(),
        size: item['size'],
        store_id: item['store_id'],
        total: item['total'],
      current_stock: item['current_stock'].toString(),
      shipping_cost: item['shipping_cost'],
      shipping_type: item['shipping_type'],
      url: item['url'],
      type: item['type']
    );
    int exists = 0;
    CartModel aa;

    for (CartModel item in cart) {
      if (_item.id == item.id && _item.title == item.title) {
        exists += 1;
        if(item.quantity != _item.quantity){
          item.quantity = _item.quantity;
          box.putAt(cart.reversed.toList().indexOf(item), item);
        }
        aa = item;
      }
    }

    if (exists < 1) {
      box.add(_item);
    } else {
      if(how != 'online')
      updateAddItem(aa);
    }

    getCartItem();
    var snackbar = SnackBar(
      content: Text("Item Added"),
    );
    EasyLoading.dismiss();

    if(how != 'online'){
      try {
        _key.currentState.showSnackBar(snackbar);
      } catch (e) {

        EasyLoading.showInfo("Cart Updated");
      }
    }

    notifyListeners();
    if(how != "online")
      sendOrder();
  }

  sendOrder() async {
    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _carts = [];

    for (var add in cart) {
      _carts.add({
        "id": add.id,
        "store_id": add.store_id,
        "name": add.title,
        "quantity": add.quantity,
        "price": add.price,
        "image":add.image,
        "total": add.total,
        "variants": {"color": add.color, "size": add.size},
        "current_stock":add.current_stock,
        "shipping_cost": add.shipping_cost,
        "shipping_type": add.shipping_type,
        "url": add.url,
        'type':add.type
      });
    }

    final _data = {"user_id": user_id, "cart_data": json.encode(_carts)};

    try {
      http.Response response = await http.post(
        Uri.parse(base_url + "user/cart-process"),
        body: _data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $user_token",
        },
      );

      if (response.statusCode < 205) {


      } else {

      }
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showInfo("No internet connection");
    }
  }

  getCartItem() async {
    final box = await Hive.openBox<CartModel>('cart');

    cart = box.values.toList().reversed.toList();

    notifyListeners();
  }

  void updateAddItem(CartModel _item) async{
    final nu = int.parse(_item.quantity) + 1;
    _item.quantity = nu.toString();
    final b = int.parse(_item.quantity) * double.parse(_item.price);
    _item.total = b.toString();
    final box = await Hive.openBox<CartModel>('cart');

    box.putAt(cart.reversed.toList().indexOf(_item), _item);
    getCartItem();
    sendOrder();
  }

  void updateSubItem(CartModel _item) async {
    var box = await Hive.openBox<CartModel>('cart');
    if (int.parse(_item.quantity) > 1) {
      final nu = int.parse(_item.quantity) - 1;
      _item.quantity = nu.toString();
      final b = int.parse(_item.quantity) * double.parse(_item.price);
      _item.total = b.toString();
      box.putAt(cart.reversed.toList().indexOf(_item), _item);
    } else {

      box.deleteAt(cart.reversed.toList().indexOf(_item));
    }

    getCartItem();
    sendOrder();
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
    box.deleteAt(cart.reversed.toList().indexOf(_item));

    getCartItem();
    sendOrder();
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
  addAddress(Map item, _key, how) async {
    var box = await Hive.openBox<Address>('address');
    int exists = 0;
    final _item = Address(
        address: item['address'],
        region: item['region'],
        phone: item['phone'],
        city: item['city'],
        recipient: item['recipient'],
        recipient_number: item['recipient_number'],
        defaultt: item['defaultt'],
        fee: item['fee']
    );

    saveAdds = box.values.toList().reversed.toList();

    for (var i in saveAdds) {
      if (i.address.toString().toLowerCase() ==
          _item.address.toString().toLowerCase() && i.region.toString().toLowerCase() == _item.region.toString().toLowerCase()) {
        exists += 1;
      } else {}
    }
    if (exists < 1) {
      box.add(_item);
    }

    getAdds();
    EasyLoading.dismiss();
    if(how != "online"){
      EasyLoading.showInfo("Address Saved");
      EasyLoading.dismiss();
    }
    notifyListeners();
  }

  getAdds() async {
    final box = await Hive.openBox<Address>('address');

    saveAdds = box.values.toList().reversed.toList();

    notifyListeners();
  }

  deletefromDisk(table)async{
    final box = await Hive.openBox<Address>(table);
    // final box1 = await Hive.openBox<CartModel>('cart');
    // final box2 = await Hive.openBox<SearchedWord>('searched');
    box.deleteFromDisk();
    // box1.deleteFromDisk();
    // box2.deleteFromDisk();

  }

  void sendAddress(Map item, _key) async {
    EasyLoading.show(status: "Saving Address");

    addAddress(item, _key, "offl");
    apiAddress();
  }

  apiAddress() async {
    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _adds = [];

    for (var add in saveAdds) {
      _adds.add({
        "region": add.region.toString(),
        "address": add.address.toString(),
        "city": add.city.toString(),
        "phone": add.phone.toString(),
        "recipient": add.recipient.toString(),
        "recipient_number": add.recipient_number.toString(),
        "default": add.defaultt.toString(),
        "fee":add.fee.toString()
      });
    }

    final _data = {"user_id": user_id, "addresses": json.encode(_adds)};

    try {
      http.Response response = await http.post(
        Uri.parse(base_url + "user/address-process"),
        body: _data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $user_token",
        },
      );
      if(response.statusCode < 205){
        EasyLoading.dismiss();

      }
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showInfo("No internet connection");
      EasyLoading.dismiss();
    }
  }

  void updateAddress(Address add, Map _item) async {
    add.defaultt = _item['default'];
    add.recipient = _item['recipient'];
    add.recipient_number = _item['recipient_number'];
    add.phone = _item['phone'];
    add.address = _item['address'];
    add.region = _item['region'];
    add.city = _item['city'];

    getAdds();

    apiAddress();
  }

  void deleteAddress(Address add) async {
    var box = await Hive.openBox<Address>('address');
    box.deleteAt(saveAdds.indexOf(add));
    getAdds();

    apiAddress();
  }

  ///End Shipping

  ///WISHLIST

  void addWishList(WishItem _item, how) async {

    var box = await Hive.openBox<WishItem>('wishlist');


    int exists = 0;


    for (WishItem item in wishlist) {
      if (_item.prodid == item.prodid && _item.title == item.title) {
        exists += 1;
      }
    }

    if (exists < 1) {
      box.add(_item);
    }

    getWishList();
    if(how != "online")
      apiWishlist();
  }

  apiWishlist() async {
    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _adds = [];

    for (var wish in wishlist) {
      _adds.add(
        {
          "id": wish.prodid,
          "store_id": wish.store_id,
          "name": wish.title,
          "quantity": wish.quantity,
          "price": wish.price,
          "image":wish.image,
          "total": wish.total,
          "variants": {"color": wish.color, "size": wish.size},
          "current_stock":wish.current_stock,
          "shipping_cost": wish.shipping_cost,
          "shipping_type": wish.shipping_type,
          "url": wish.url,
          'type':wish.type
        },
      );
    }

    final _data = {"user_id": user_id, "wishlist_data": json.encode(_adds)};

    try {
      http.Response response = await http.post(
        Uri.parse(base_url + "user/wishlist-process"),
        body: _data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $user_token",
        },

      );


    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showInfo("No internet connection");
    }
  }

  void removeWishList(WishItem _item) async {
    var box = await Hive.openBox<WishItem>('wishlist');
    var a;
    for (var b in wishlist) {
      if (b.prodid == _item.prodid && b.title == _item.title) {
        a = b;
      }
    }

    box.deleteAt(wishlist.indexOf(a));

    getWishList();

    apiWishlist();
  }

  void getWishList() async {
    var box = await Hive.openBox<WishItem>('wishlist');

    wishlist = box.values.toList().reversed.toList();

    notifyListeners();
  }

  ///end WISHLIST

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
    List addresses = await GetFunc.getAddresses();

    for (var item in addresses) {
      addAddress(item, "aa", 'online');
    }

    notifyListeners();
  }


  void getWishListData() async {
    List wishes = await GetFunc.getWishListData();

    for (var item in wishes) {
      WishItem aa = WishItem(
          quantity: item['quantity'],
          price: item['price'],
          image: item['image'], //To Be modified
          title: item['name'],
          color: item['variants']['color'],
          prodid: item['id'].toString(),
    size: item['variants']['size'],
    store_id: item['store_id'],
    total: item['total'],
        url: item['url'],
          current_stock: item['current_stock'],
          shipping_cost: item['shipping_cost'],
          shipping_type: item['shipping_type'],
          type: item['type']
      );
      addWishList(item, "online");
    }

    notifyListeners();
  }

  void getCartData() async {
    List cc = await GetFunc.getCartData();

    for (var item in cc) {

      Map a = {
        "quantity": item['quantity'],
        "price": item['price'],
        "image": item['image'], //To Be modified
        "title": item['name'],
        "color": item['variants']['color'],
        "id": item['id'].toString(),
        "size": item['variants']['size'],
        "store_id": item['store_id'],
        "total": item['total'],
        "url":item['url'],
        "current_stock": item['current_stock'],
        "shipping_cost": item['shipping_cost'],
        "shipping_type": item['shipping_type'],

        "type": item['type']

      };
      addToCart(a, "aa", "online");
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

  void getAllBusinessTypes() async {
    allBusinessType = await GetFunc.getAllBusiness();
    notifyListeners();
  }

  void getAllEvent() async {
    allevents = await GetFunc.getAllEvent();
    notifyListeners();
  }

  void getAllBuses() async {
    allbuses = await GetFunc.getAllBuses();
    notifyListeners();
  }

  void getDestinations() async {
    alldestinations = await GetFunc.getDestinations();
    notifyListeners();
  }

  void setShipping(Address data) {
    shipping = data;

    notifyListeners();
  }


  void getConfig()async{
    config = await GetFunc.getConfig();
    notifyListeners();
  }


  void getUserDetail()async{
    userDetail = await GetFunc.getUserDetail();
    notifyListeners();
  }

  void getOrders() async {
    allorders = await GetFunc.getOrders();
    notifyListeners();
  }


  void getPlacedOrders() async {
    placedOrders = await GetFunc.getPlacedOrders();
    notifyListeners();
  }

  void getAuction() async {
    auctions = await GetFunc.getAuction();

    notifyListeners();
  }

  void getRegions()async{
    regions = await GetFunc.getRegions();



    notifyListeners();
  }

}
