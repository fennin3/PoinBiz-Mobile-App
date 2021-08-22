import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/add_address.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/edit_shipping.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

Map toUseaddress;

class delivery extends StatefulWidget {
  @override
  _deliveryState createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  bool checkBoxValue = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postal = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _recipient = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int nu = 0;

  void addAddress() async {
    EasyLoading.show(status: "Saving Address");
    final _userId = await UserData.getUserId();
    final _userToken = await UserData.getUserToken();
    final _data = {
      "user_id": _userId.toString(),
      "addresses": json.encode([
        {
          "name": _name.text,
          "address": _address.text,
          "postal": _postal.text,
          "phone": _phone.text,
          "recipient": _recipient.text,
          "default": checkBoxValue
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _name.dispose();
    _address.dispose();
    _postal.dispose();
    _phone.dispose();
    _recipient.dispose();
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
    z();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);

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
      body: SafeArea(
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
                          TextFormField(
                            controller: _name,
                            validator: (e) {
                              if (_name.text.isEmpty) {
                                return "Please enter name";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                labelText: "Name",
                                hintStyle: TextStyle(color: Colors.black54)),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
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
                            controller: _postal,
                            validator: (e) {
                              if (_postal.text.isEmpty) {
                                return "Please enter postal address";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Postal Address",
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
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
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
                                  "name": _name.text,
                                  "phone": _phone.text,
                                  "postal": _postal.text,
                                  "recipient": _recipient.text,
                                  "defaultt": checkBoxValue
                                }, "aa");
                                z();
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 55.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0))),
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
                                                    "Collect at any of our Pickup Stations(Cheaper Fees)",
                                                    style: TextStyle(
                                                        fontSize: 14)))
                                          ],
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            "SELECT A PICKUP STATION",
                                            style: TextStyle(color: appColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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
                                              backgroundColor: Colors.grey[400],
                                              child: CircleAvatar(
                                                radius: 7,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor: Colors.white,
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
                                    Text("GHc 1699.00")
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
                                      "GHc 0.00",
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
                                      "GHc 1699.00",
                                      style: TextStyle(
                                          fontSize: 16,
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
                                    Text("Your Points: 150000 (Ghc 25)")
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
                                          child: TextField(),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                          color: appColor,
                                          height: 45,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Center(
                                                  child: Text(
                                                "APPLY",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )))),
                                    ),
                                    Card(
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
                                              )))),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  elevation: 2,
                                  child: Container(
                                    width: double.infinity,
                                    color: appColor,
                                    height: 50,
                                    child: Center(
                                      child: Text("PROCEED TO PAYMENT",
                                          style:
                                              TextStyle(color: Colors.white)),
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
                      "${data.name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      "${data.postal}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                      "${data.phone}",
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

class AddressWidget1 extends StatelessWidget {
  final index;
  final nu;

  AddressWidget1({this.index, this.nu});

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
                      color: index != nu ? Colors.black : Colors.green)),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_pro.saveAdds[index].name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[index].address}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[index].postal}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[index].recipient}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_pro.saveAdds[index].phone}",
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
                      backgroundColor:
                          index == nu ? Colors.green : Colors.white,
                    ),
                  ),
                )),
            Positioned(
                right: 7,
                bottom: 7,
                child: InkWell(
                    onTap: () => _pro.deleteAddress(_pro.saveAdds[index]),
                    child: Icon(
                      Icons.delete,
                      size: 30,
                    )))
          ],
        ));
  }
}
