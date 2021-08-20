import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({Key key}) : super(key: key);

  @override
  _CreateAddressPageState createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  bool checkBoxValue = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postal = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _recipient = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          "Add Address",
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
                        final a = {
                          "name": _name.text,
                          "address": _address.text,
                          "postal": _postal.text,
                          "phone": _phone.text,
                          "recipient": _recipient.text,
                          "default": checkBoxValue
                        };
                        _pro.sendAddress(a, _key);
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
