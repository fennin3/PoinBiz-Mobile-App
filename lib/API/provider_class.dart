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

bool aaV(String a) {
  return a.toLowerCase() == "true";
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class PoinBizProvider with ChangeNotifier {
  List allcategories;
  List allbanners = [];
  List allpromos = [];
  List allProducts = [];

  List alleventCat = [];
  List alldestinations = [];
  List allbuses = [];
  List allevents = [];
  List<Address> saveAdds = [];
  bool loading;
  Address shipping;
  List<CartModel> cart = [];
  List<SearchedWord> searchedWords = [];
  List<WishItem> wishlist = [];
  int totalPrice = 0;

  ///Cart
  addToCart(Map item, _key, how) async {
    EasyLoading.show(status: "Updating cart");
    // final imageName = getRandomString(10);
    Directory documentDirectory;

    // if(item['image']!="ticket") {
    //   await MyUtils.downloadAndSaveImage(item['image'], imageName);
    //   documentDirectory = await getApplicationDocumentsDirectory();
    // }
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
        total: item['total']);
    int exists = 0;
    CartModel aa;

    for (CartModel item in cart) {
      if (_item.id == item.id && _item.title == item.title) {
        exists += 1;
        aa = item;
      }
    }

    if (exists < 1) {
      box.add(_item);
    } else {
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
        "total": add.total,
        "variants": {"color": add.color, "size": add.size}
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

    cart = box.values.toList();

    notifyListeners();
  }

  void updateAddItem(CartModel _item) {
    final nu = int.parse(_item.quantity) + 1;
    _item.quantity = nu.toString();
    final b = int.parse(_item.quantity) * double.parse(_item.price);
    _item.total = b.toString();
    getCartItem();
    sendOrder();
  }

  void updateSubItem(CartModel _item) async {
    if (int.parse(_item.quantity) > 1) {
      final nu = int.parse(_item.quantity) - 1;
      _item.quantity = nu.toString();
      final b = int.parse(_item.quantity) * double.parse(_item.price);
      _item.total = b.toString();
    } else {
      var box = await Hive.openBox<CartModel>('cart');
      box.deleteAt(cart.indexOf(_item));
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
    int exists = 0;

    final _item = Address(
        address: item['address'],
        name: item['name'],
        phone: item['phone'],
        postal: item['postal'],
        recipient: item['recipient'],
        defaultt: aaV(item['default']));

    saveAdds = box.values.toList().reversed.toList();

    for (var i in saveAdds) {
      if (i.name.toString().toLowerCase() ==
          _item.name.toString().toLowerCase()) {
        exists += 1;
      } else {}
    }
    if (exists < 1) {
      box.add(_item);
    }

    var snackbar = SnackBar(
      content: Text("Address Saved"),
    );

    if (_key != "aa") _key.currentState.showSnackBar(snackbar);

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
    EasyLoading.show(status: "Saving Address");

    addAddress(item, _key);
    apiAddress();
  }

  apiAddress() async {
    final user_id = await UserData.getUserId();
    final user_token = await UserData.getUserToken();
    List _adds = [];

    for (var add in saveAdds) {
      _adds.add({
        "name": add.name.toString(),
        "address": add.address.toString(),
        "postal": add.postal.toString(),
        "phone": add.phone.toString(),
        "recipient": add.recipient.toString(),
        "default": add.defaultt.toString()
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
      EasyLoading.dismiss();
      EasyLoading.showInfo("Address Saved");
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showInfo("No internet connection");
    }
  }

  void updateAddress(Address add, Map _item) async {
    add.defaultt = _item['default'];
    add.recipient = _item['recipient'];
    add.phone = _item['phone'];
    add.address = _item['address'];
    add.name = _item['name'];

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
          "total": wish.total,
          "variants": {"color": wish.color, "size": wish.size}
        },
      );
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
      addAddress(item, "aa");
    }

    notifyListeners();
  }


  void getWishListData() async {
    List wishes = await GetFunc.getWishListData();

    for (var item in wishes) {
      WishItem aa = WishItem(
          quantity: item['quantity'],
          price: item['price'],
          image: "https://images.unsplash.com/photo-1606171687424-429b65889052?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHBzNXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", //To Be modified
          title: item['name'],
          color: item['variants']['color'],
          prodid: item['id'].toString(),
    size: item['variants']['size'],
    store_id: item['store_id'],
    total: item['total']
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
        "image": "ticket", //To Be modified
        "title": item['name'],
        "color": item['variants']['color'],
        "id": item['id'].toString(),
        "size": item['variants']['size'],
        "store_id": item['store_id'],
        "total": item['total']
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
}
