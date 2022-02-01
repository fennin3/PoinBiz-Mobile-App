import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/MyOrders.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/add_address.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/edit_shipping.dart';
import 'package:treva_shop_flutter/UI/Payment/payment_web.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:toast/toast.dart';

Map toUseaddress;

class delivery extends StatefulWidget {
  @override
  _deliveryState createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  bool checkBoxValue = false;
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _recipient = TextEditingController();
  final TextEditingController _recipientNumber = TextEditingController();
  final TextEditingController _points = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int nu = 0;
  String regionName = "";
  Data region;
  String cityName = "";
  List<Cities> _cities = [];
  Cities city;
  String tempPoints = "";
  Address shipping;
  String totalAmount = "";
  bool showSpin = false;

  void addAddress() async {
    EasyLoading.show(status: "Saving Address");
    final _userId = await UserData.getUserId();
    final _userToken = await UserData.getUserToken();
    final _data = {
      "user_id": _userId.toString(),
      "addresses": json.encode([
        {
          "region": regionName,
          "address": _address.text,
          "city": cityName,
          "phone": _phone.text,
          "recipient": _recipient.text,
          "recipient_number": _recipientNumber.text,
          "default": checkBoxValue,
          "fee": city.fee.toString()
        }
      ])
    };

    http.Response response = await http.post(
      Uri.parse(base_url + "user/address-process"),
      body: _data,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_userToken",
      },
    );

    EasyLoading.dismiss();

    if (response.statusCode < 206) {
      EasyLoading.showSuccess("${json.decode(response.body)['message']}");
    } else {
      EasyLoading.showError("${json.decode(response.body)['message']}");
    }
  }

  editShipping() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [ShippingAddresses()],
          );
        });
  }

  String cost_ship(total, shipping) {
    final a = double.parse(total) + double.parse(shipping);
    return a.toString();
  }

  getTotal(_amount, totalPoints, a) {
    a = 1 / int.parse(a);

    double pointsIncash = a;
    double amount;
    int points;
    if (_amount.isNotEmpty) {
      amount = double.parse(_amount);
    } else {
      amount = 0.0;
    }

    if (tempPoints.isNotEmpty &&
        int.parse(tempPoints.toString()) <= int.parse(totalPoints.toString())) {
      points = int.parse(tempPoints.toString());
    } else {
      points = 0;
    }

    double total = amount - (points * pointsIncash);
    return total > 0 ? total.toStringAsFixed(2).toString() : 0.00.toString();
  }

  void placeOrder(Address address, amount, points, a) async {
    setState(() {
      showSpin = true;
    });
    final _userId = await UserData.getUserId();
    final _userToken = await UserData.getUserToken();

    final _data = {
      "user_id": _userId.toString(),
      "address": json.encode({
        "region": address.region,
        "address": address.address,
        "city": address.city,
        "phone": address.phone,
        "recipient": address.recipient,
        "recipient_number": address.recipient,
        "default": address.defaultt,
        "fee": address.fee
      }),
      "amount": getTotal(amount, points, a).toString(),
      "points": _points.text
    };

    http.Response response = await http.post(
        Uri.parse(base_url + "user/place-order"),
        body: _data,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${_userToken}"});

    if (response.statusCode < 206) {
      print(response.statusCode);
      setState(() {
        showSpin = false;
      });
      // EasyLoading.showSuccess("${json.decode(response.body)['message']}");
      setState(() {
        showSpin = false;
      });

      if (json
          .decode(response.body)['data']['authorization_url']
          .toString()
          .contains('thank')) {
        Toast.show('Order has been placed successfully', context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => order()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentWeb(
                      initUrl: json.decode(response.body)['data']
                          ['authorization_url'],
                      where: "cart",
                    )));
      }
    } else {
      print(response.statusCode);
      setState(() {
        showSpin = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _address.dispose();
    _phone.dispose();
    _recipient.dispose();
    _points.dispose();
    _recipientNumber.dispose();
  }

  void z() {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    if (_pro.saveAdds.isNotEmpty) {
      final _default =
          _pro.saveAdds.where((element) => element.defaultt == true).toList();

      if (_default.isNotEmpty) {
        final c = _default[0];
        _pro.setShipping(c);
      } else {
        final c = _pro.saveAdds[0];
        _pro.setShipping(c);
      }
    }
  }

  // void a(b) {
  //   final _pro = Provider.of<PoinBizProvider>(context, listen: false);
  //   if (_pro.saveAdds.isNotEmpty) {
  //     final _default =
  //     _pro.saveAdds.where((element) => element.defaultt == true).toList();
  //
  //     if (_default.isNotEmpty) {
  //       final c = _default[0];
  //       _pro.setShipping(c);
  //     } else {
  //       final c = _pro.saveAdds[0];
  //       _pro.setShipping(c);
  //     }
  //   }
  //   _pro.setShipping(b);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    _pro.getAdds();

    Future.delayed(Duration.zero, () async {
      z();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    _pro.getAdds();
    EasyLoading.dismiss();
    bool noCharge = false;
    if (_pro.cart.length < 2 &&
        _pro.cart.isNotEmpty &&
        _pro.cart[0].type != 'product') {
      noCharge = true;
    } else {
      for (var i in _pro.cart) {
        if (i.type != 'product') {
          noCharge = true;
        } else {
          noCharge = false;
        }
      }
    }

    shipping = _pro.shipping;
    totalAmount = _pro.getTotal();
    var allTotal = getTotal(
        cost_ship(
            _pro.getTotal().toString(),
            noCharge
                ? '0.0'
                : _pro.shipping.fee != null
                    ? _pro.shipping.fee.toString()
                    : "0.0"),
        _pro.userDetail['points'],
        _pro.config['points_per_cedi']);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          "Checkout",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF6991C7)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpin,
        color: Colors.black38,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Processing",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 5,
            ),
            CircularProgressIndicator(
              color: appColor,
            ),
          ],
        ),
        child: SafeArea(
          child: _pro.saveAdds.isEmpty
              ? SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Please add your address we can deliver your order to.",
                              style: TextStyle(
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.0,
                                  color: Colors.black54,
                                  fontFamily: "Gotik"),
                            ),
                            Padding(padding: EdgeInsets.only(top: 50.0)),
                            DropdownSearch<Data>(
                              mode: Mode.BOTTOM_SHEET,
                              label: "Region",
                              hint: "Select Region",
                              items: [for (var a in _pro.regions.data) a],
                              itemAsString: (Data u) => u.name,
                              onChanged: (Data data) {
                                setState(() {
                                  if (data != null) {
                                    cityName = "";
                                    _cities = [];
                                    regionName = data.name;
                                    region = data;
                                    _cities = data.cities;
                                  } else {
                                    regionName = "";
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownSearch<Cities>(
                              mode: Mode.BOTTOM_SHEET,
                              label: "City",
                              hint: "Select City",
                              items: [for (var a in _cities) a],
                              itemAsString: (Cities u) => u.name,
                              onChanged: (Cities data) {
                                setState(() {
                                  if (data != null) {
                                    cityName = data.name;
                                    city = data;
                                  } else {
                                    cityName = "";
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _address,
                              validator: (e) {
                                if (_address.text.isEmpty) {
                                  return "Please enter address";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Address",
                                  hintStyle: TextStyle(color: Colors.black54)),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            TextFormField(
                              controller: _phone,
                              validator: (e) {
                                if (_phone.text.isEmpty) {
                                  return "Please enter phone";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "phone number",
                                  hintStyle: TextStyle(color: Colors.black54)),
                              keyboardType: TextInputType.phone,
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            TextFormField(
                              controller: _recipient,
                              validator: (e) {
                                if (_recipient.text.isEmpty) {
                                  return "Please enter recipient name";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Recipient name",
                                  hintStyle: TextStyle(color: Colors.black54)),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            TextFormField(
                              controller: _recipientNumber,
                              decoration: InputDecoration(
                                  labelText: "Recipient number",
                                  hintStyle: TextStyle(color: Colors.black54)),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            Row(
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                      value: checkBoxValue,
                                      activeColor: appColor,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          checkBoxValue = newValue;
                                        });
                                      }),
                                ),
                                Expanded(
                                    child: Text(
                                  "Make address your default address ?",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blue),
                                )),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 40.0)),
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushReplacement(
                                //     PageRouteBuilder(
                                //         pageBuilder: (_, __, ___) => payment()));
                                if (_formKey.currentState.validate()) {
                                  _pro.sendAddress({
                                    "address": _address.text,
                                    "region": regionName,
                                    "phone": _phone.text,
                                    "city": cityName,
                                    "recipient": _recipient.text,
                                    "recipient_number": _recipientNumber.text,
                                    "defaultt": checkBoxValue,
                                    "fee": city.fee.toString()
                                  }, "aa");

                                  Future.delayed(Duration(seconds: 2))
                                      .then((value) => z());
                                }
                              },
                              child: Container(
                                height: 55.0,
                                width: 300.0,
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.5,
                                        letterSpacing: 1.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : _pro.shipping == null
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: appColor,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 10, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckoutTitle(
                                    text: "ADDRESS DETAILS",
                                  ),
                                  AddressWidget(
                                    fun: editShipping,
                                    data: _pro.shipping,
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  CheckoutTitle(
                                    text: "SELECT A DELIVERY METHOD",
                                  ),
                                  // Card(
                                  //   elevation: 1,
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(20),
                                  //     width: double.infinity,
                                  //     child: Column(
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             CircleAvatar(
                                  //               radius: 9,
                                  //               backgroundColor: appColor,
                                  //               child: CircleAvatar(
                                  //                 radius: 7,
                                  //                 backgroundColor: Colors.white,
                                  //                 child: CircleAvatar(
                                  //                   radius: 5,
                                  //                   backgroundColor: appColor,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             SizedBox(
                                  //               width: 20,
                                  //             ),
                                  //             Expanded(
                                  //                 child: Text(
                                  //                     "Collect at any of our Pickup Stations(Cheaper Fees)",
                                  //                     style: TextStyle(
                                  //                         fontSize: 14)))
                                  //           ],
                                  //         ),
                                  //         Divider(),
                                  //         Padding(
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 5.0),
                                  //           child: Text(
                                  //             "SELECT A PICKUP STATION",
                                  //             style: TextStyle(color: appColor),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Card(
                                    elevation: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 9,
                                                backgroundColor: appColor,
                                                child: CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: appColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      "Home and Office Delivery",
                                                      style: TextStyle(
                                                          fontSize: 14)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                          Card(
                            elevation: 1,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Subtotal"),
                                      Text("GHc ${_pro.getTotal().toString()}")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Delivery",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "GHc ${noCharge ? 0 : _pro.shipping.fee}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: appColor,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "GHc ${double.parse(_pro.getTotal().toString()) + double.parse(noCharge ? '0.0' : _pro.shipping.fee ?? '0.0')}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CheckoutTitle(text: "USE POINT"),
                                      Text(
                                        "Your Points: ${_pro.userDetail['points']} (Ghc ${int.parse(_pro.userDetail['points'].toString() ?? '0') / int.parse(_pro.config['points_per_cedi'].toString())})",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                          width: 180,
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: TextField(
                                              controller: _points,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (int.parse(_points.text) >
                                              int.parse(_pro
                                                  .userDetail['points']
                                                  .toString())) {
                                            final snackBar = SnackBar(
                                                content: Text(
                                                    'You have insufficient points'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          } else {
                                            setState(() {
                                              tempPoints = _points.text.toString();
                                            });

                                            EasyLoading.dismiss();
                                          }
                                        },
                                        child: Card(
                                          child: Container(
                                              color: appColor,
                                              height: 45,
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Center(
                                                      child: Text(
                                                    "APPLY",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            final allPointCash = int.parse(_pro
                                                    .userDetail['points']
                                                    .toString()) /
                                                int.parse(_pro
                                                    .config['points_per_cedi']);
                                            if (allPointCash <=
                                                double.parse(allTotal.toString())) {
                                              tempPoints = _pro
                                                  .userDetail['points']
                                                  .toString();
                                              _points.text = tempPoints;
                                            } else {
                                              double a =
                                                      double.parse(allTotal.toString()) *
                                                  int.parse(_pro.config[
                                                      'points_per_cedi'].toString());
                                              var z = a.toString().split('.');

                                              tempPoints = z[0];

                                              print(tempPoints);
                                              _points.text = tempPoints;
                                            }
                                          });
                                        },
                                        child: Card(
                                          child: Container(
                                            color: appColor,
                                            height: 45,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Center(
                                                child: Text(
                                                  "APPLY ALL",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () => placeOrder(
                                        shipping,
                                        cost_ship(
                                            totalAmount,
                                            noCharge
                                                ? '0.0'
                                                : _pro.shipping.fee ??
                                                    0.00.toString()),
                                        _pro.userDetail['points'],
                                        _pro.config['points_per_cedi']),
                                    child: Card(
                                      elevation: 2,
                                      child: Container(
                                        width: double.infinity,
                                        color: appColor,
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                              "PROCEED TO PAYMENT - ( GHc ${allTotal} )",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class CheckoutTitle extends StatelessWidget {
  final String text;

  CheckoutTitle({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: Colors.black26),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final Function fun;
  final Address data;

  AddressWidget({this.fun, this.data});

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Stack(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding:
                    EdgeInsets.only(top: 20, right: 30, left: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.region}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${data.city}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${data.address}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${data.phone}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${data.recipient}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${data.recipient_number}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                  onTap: () {
                    fun();
                  },
                  child: Icon(
                    Icons.change_circle,
                    size: 30,
                    color: appColor,
                  ),
                )),
            Positioned(
                right: 10,
                bottom: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditShippingPage(
                                  data: data,
                                )));
                  },
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: appColor,
                  ),
                )),
          ],
        ));
  }
}

class ShippingAddresses extends StatefulWidget {
  const ShippingAddresses({Key key}) : super(key: key);

  @override
  _ShippingAddressesState createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
  int nu = 0;

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 17, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          for (var add in _pro.saveAdds)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  nu = _pro.saveAdds.indexOf(add);
                                });
                              },
                              child: AddressWidget1(
                                nu: nu,
                                index: _pro.saveAdds.indexOf(add),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAddressPage())),
                            child: Container(
                              child: Container(
                                  color: appColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Add New",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          if (_pro.saveAdds.length > 1)
                            InkWell(
                              onTap: () {
                                // setState(() {
                                //   toUseaddress = {
                                //     "name": "Changed Address",
                                //     "address": "Tema Community 9",
                                //     "postal": "Post Office Box 32",
                                //     "recipient": "Ennin Francis",
                                //     "phone": "0541752049"
                                //   };
                                // });
                                _pro.setShipping(_pro.saveAdds[nu]);
                                Navigator.pop(context);
                              },
                              child: Container(
                                color: appColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Use",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            Positioned(
                right: 10,
                top: 5,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ))),
          ],
        ));
  }
}

class AddressWidget1 extends StatefulWidget {
  final index;
  final nu;

  AddressWidget1({this.index, this.nu});

  @override
  State<AddressWidget1> createState() => _AddressWidget1State();
}

class _AddressWidget1State extends State<AddressWidget1> {
  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Stack(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: widget.index != widget.nu
                          ? Colors.black
                          : Colors.green)),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_pro.saveAdds[widget.index].region}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[widget.index].city}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[widget.index].address}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[widget.index].recipient}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[widget.index].phone}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 7,
                top: 7,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: widget.index == widget.nu
                          ? Colors.green
                          : Colors.white,
                    ),
                  ),
                )),
            Positioned(
                right: 7,
                bottom: 7,
                child: InkWell(
                    onTap: () => _pro.deleteAddress(
                        _pro.saveAdds.reversed.toList()[widget.index]),
                    child: Icon(
                      Icons.delete,
                      size: 30,
                    )))
          ],
        ));
  }
}
