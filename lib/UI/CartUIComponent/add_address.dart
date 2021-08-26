import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({Key key}) : super(key: key);

  @override
  _CreateAddressPageState createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  bool checkBoxValue = false;

  final TextEditingController _address = TextEditingController();

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _recipient = TextEditingController();
  final TextEditingController _recipientNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  int nu = 0;
  String regionName = "";
  Data region;
  String cityName = "";
  List<Cities> _cities=[];
  Cities city;
  String tempPoints = "";
  Address shipping;
  String totalAmount ="";



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _address.dispose();
    _phone.dispose();
    _recipient.dispose();
    _recipientNumber.dispose();
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
                    label:
                    "Region",
                    hint:
                    "Select Region",
                    items: [
                      for(var a in _pro.regions.data)
                        a
                    ],
                    itemAsString: (Data u) => u.name,
                    onChanged: (Data data){
                      setState(() {
                        if(data != null) {
                          cityName="";
                          _cities=[];
                          regionName = data.name;
                          region=data;
                          _cities = data.cities;

                        }else{
                          regionName ="";

                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownSearch<Cities>(
                    mode: Mode.BOTTOM_SHEET,
                    label:
                    "City",
                    hint:
                    "Select City",
                    items: [
                      for(var a in _cities)
                        a
                    ],
                    itemAsString: (Cities u) => u.name,
                    onChanged: (Cities data){
                      setState(() {
                        if(data != null) {

                          cityName = data.name;
                          city=data;


                        }else{
                          cityName ="";

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
                          "region": regionName,
                          "phone": _phone.text,
                          "city": cityName,
                          "recipient": _recipient.text,
                          "recipient_number": _recipientNumber.text,
                          "defaultt": checkBoxValue,
                          "fee":city.fee.toString()
                        }, "aa");


                        try{
                          _pro.setShipping(_pro.saveAdds[0]);
                        }
                        catch(e){}
                      }
                    },
                    child: Container(
                      height: 55.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          color: appColor,
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
    );
  }
}
