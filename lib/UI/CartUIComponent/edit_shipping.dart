import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;

class EditShippingPage extends StatefulWidget {
  final Address data;
  final add;

  EditShippingPage({this.data,this.add});

  @override
  _EditShippingPageState createState() => _EditShippingPageState();
}

class _EditShippingPageState extends State<EditShippingPage> {
  bool checkBoxValue = false;
  String _name = "";
  String _address = "";
  String _postal = "";
  String _phone = "";
  String _recipient = "";
  final _formKey = GlobalKey<FormState>();

  void addAddress() async {
    EasyLoading.show(status: "Saving Address");
    final _userId = await UserData.getUserId();
    final _userToken = await UserData.getUserToken();
    final _data = {
      "user_id": _userId.toString(),
      "addresses": [
        {
          "name": _name,
          "address": _address,
          "postal": _postal,
          "phone": _phone,
          "recipient": _recipient,
          "default": checkBoxValue
        }
      ]
    };

    http.Response response = await http.post(
      Uri.parse(base_url + "user/address-process"),
      body: json.encode(_data),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_userToken",
        "content-type": "application/json"
      },
    );

    EasyLoading.dismiss();

    if (response.statusCode < 206) {
      EasyLoading.showSuccess("${json.decode(response.body)['message']}");
      setState(() {});
    } else {
      EasyLoading.showError("${json.decode(response.body)['message']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          "Edit Address",
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: widget.data.name,
                    onChanged: (e) {
                      setState(() {
                        _name = e;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Name",
                        hintStyle: TextStyle(color: Colors.black54)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    initialValue: widget.data.address,
                    onChanged: (e) {
                      setState(() {
                        _address = e;
                      });
                    },
                    validator: (e) {
                      if (_address.isEmpty) {
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
                    initialValue: widget.data.postal,
                    onChanged: (e) {
                      setState(() {
                        _postal = e;
                      });
                    },
                    validator: (e) {
                      if (_postal.isEmpty) {
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
                    initialValue: widget.data.phone,
                    onChanged: (e) {
                      setState(() {
                        _phone = e;
                      });
                    },
                    validator: (e) {
                      if (_phone.isEmpty) {
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
                    initialValue: widget.data.recipient,
                    onChanged: (e) {
                      setState(() {
                        _recipient = e;
                      });
                    },
                    validator: (e) {
                      if (_recipient.isEmpty) {
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
                        style: TextStyle(fontSize: 16, color: Colors.blue),
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
                        addAddress();
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
      ),
    );
  }
}
