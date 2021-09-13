import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

class EditShippingPage extends StatefulWidget {
  final Address data;
  final add;

  EditShippingPage({this.data, this.add});

  @override
  _EditShippingPageState createState() => _EditShippingPageState();
}

class _EditShippingPageState extends State<EditShippingPage> {
  bool checkBoxValue = false;
  final _formKey = GlobalKey<FormState>();
  int nu = 0;
  String _address="";
  String _phone="";
  String _recipient = "";
  String _recipientnumber = "";
  String regionName = "";
  Data region;
  String cityName = "";
  List<Cities> _cities = [];
  Cities city;

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
              padding:
                  const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
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
                      selectedItem: _pro.regions.data
                          .where((element) =>
                              element.name.toString().toLowerCase() ==
                              widget.data.region.toString().toLowerCase())
                          .toList()[0],
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
                      selectedItem: _pro.regions.data
                          .where((element) =>
                              element.name.toString().toLowerCase() ==
                              widget.data.region.toLowerCase())
                          .toList()[0]
                          .cities
                          .where((element) =>
                              element.name.toLowerCase() ==
                              widget.data.city.toLowerCase())
                          .toList()[0],
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
                      initialValue: widget.data.address,
                      onChanged: (e){
                        setState(() {
                          _address=e;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Address",
                          hintStyle: TextStyle(color: Colors.black54)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                      initialValue: widget.data.phone,
                      onChanged: (e){
                        setState(() {
                          _phone=e;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "phone number",
                          hintStyle: TextStyle(color: Colors.black54)),
                      keyboardType: TextInputType.phone,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                      initialValue: widget.data.recipient,
                      onChanged: (e){
                        setState(() {
                          _recipient=e;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Recipient name",
                          hintStyle: TextStyle(color: Colors.black54)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                      initialValue: widget.data.recipient_number,
                      onChanged: (e){
                        setState(() {
                          _recipientnumber=e;
                        });
                      },
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
                          _pro.updateAddress(widget.data, {
                            "default":checkBoxValue,
                            "region":regionName.isNotEmpty ? regionName : widget.data.region,
                            "recipient":_recipient.isNotEmpty ? _recipient : widget.data.recipient,
                            "recipient_number":_recipientnumber.isNotEmpty ? _recipientnumber : widget.data.recipient_number,
                            "address": _address.isNotEmpty ? _address : widget.data.address,
                            "city": cityName.isNotEmpty ? cityName : widget.data.city,
                            "phone":_phone.isNotEmpty ? _phone : widget.data.phone
                          });
                          Navigator.pop(context);
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
        ));
  }
}


