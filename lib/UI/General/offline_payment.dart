import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/Payment/payment_web.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;

class OfflinePayment extends StatefulWidget {
  const OfflinePayment({Key key}) : super(key: key);

  @override
  _OfflinePaymentState createState() => _OfflinePaymentState();
}

class _OfflinePaymentState extends State<OfflinePayment> {
  final TextEditingController _merchantId = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _points = TextEditingController();

  String tempPoints = "";

  getTotal(totalPoints, pro) {
    double a = double.parse(pro);
    a = 1 / a;

    double pointsIncash = a;
    double amount;
    int points;
    if (_amount.text.isNotEmpty) {
      amount = double.parse(_amount.text);
    } else {
      amount = 0.0;
    }

    if (tempPoints.isNotEmpty && int.parse(tempPoints) <= totalPoints) {
      points = int.parse(tempPoints);
    } else {
      points = 0;
    }

    double total = amount - (points * pointsIncash);
    return total > 0 ? total : 0.00;
  }

  void offlinePayment(pay) async {
    EasyLoading.show(status: "Processing");
    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();

    final _data = {
      "user_id": userId,
      "merchant_id": _merchantId.text,
      "points_used": _points.text.isNotEmpty ? _points.text : '0',
      "amount": _amount.text,
      "pay": pay.toString(),
      "description": _description.text
    };

    try{
      http.Response response = await http.post(
          Uri.parse(base_url + "user/offline-payment"),
          body: _data,
          headers: {HttpHeaders.authorizationHeader: "Bearer $userToken"});
      EasyLoading.dismiss();
      if (response.statusCode < 205) {
        EasyLoading.dismiss();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentWeb(initUrl: json.decode(response.body)['data']['authentication_url'], where: "offline",)));
      } else {
        EasyLoading.showError("${json.decode(response.body)['message']}");
      }
    }
    catch(e){
      EasyLoading.dismiss();
      EasyLoading.showError("Unsuccessful, Please retry");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _merchantId.dispose();
    _amount.dispose();
    _points.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "Offline Payment",
          style: auctionHeader,
        ),
        leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.35,
                width: double.infinity,
                color: appColor,
                child: Image.asset(
                  "assets/img/offline.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4))),
                        child: Theme(
                          data: ThemeData(
                            hintColor: Colors.transparent,
                          ),
                          child: TextFormField(
                            controller: _merchantId,
                            validator: (e) {
                              if (_merchantId.text.isEmpty) {
                                return "Please enter merchant ID";
                              }
                              // else if(!_email.text.contains("@") || !_email.text.contains(".com")){
                              //   return "Please enter a valid email address";
                              // }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Merchant ID",
                                labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Sans',
                                    letterSpacing: 0.3,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600)),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4))),
                        child: Theme(
                          data: ThemeData(
                            hintColor: Colors.transparent,
                          ),
                          child: TextFormField(
                            controller: _amount,
                            validator: (e) {
                              if (_amount.text.isEmpty) {
                                return "Please enter amount";
                              }
                              // else if(!_email.text.contains("@") || !_email.text.contains(".com")){
                              //   return "Please enter a valid email address";
                              // }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Amount (Ghc)",
                                labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Sans',
                                    letterSpacing: 0.3,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600)),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4))),
                        child: Theme(
                          data: ThemeData(
                            hintColor: Colors.transparent,
                          ),
                          child: TextFormField(
                            controller: _description,
                            maxLines: 4,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Description",
                                labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Sans',
                                    letterSpacing: 0.3,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600)),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckoutTitle(text: "USE POINT"),
                        Text(
                            "Your Points: ${_pro.userDetail['points']} (Ghc ${int.parse(_pro.userDetail['points'].toString()) / int.parse(_pro.config['points_per_cedi'].toString())})")
                      ],
                    ),
                    Row(
                      textBaseline: TextBaseline.ideographic,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Container(
                            width: 180,
                            height: 55,
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.4))),
                            child: Theme(
                              data: ThemeData(
                                hintColor: Colors.transparent,
                              ),
                              child: TextFormField(
                                controller: _points,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Points",
                                    labelStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Sans',
                                        letterSpacing: 0.3,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600)),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (int.parse(_points.text) >
                                int.parse(
                                    _pro.userDetail['points'].toString())) {
                              EasyLoading.showError("Insufficient Points");
                            } else {
                              EasyLoading.show(status: "Apply Points");
                              Future.delayed(Duration(seconds: 2))
                                  .then((value) {
                                EasyLoading.dismiss();
                                setState(() {

                                  tempPoints = _points.text;
                                });
                              });
                            }
                          },
                          child: Card(
                            child: Container(
                                color: appColor,
                                height: 45,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                        child: Text(
                                      "APPLY",
                                      style: TextStyle(color: Colors.white),
                                    )))),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            EasyLoading.show(status: "Apply Points");
                            Future.delayed(Duration(seconds: 2)).then((value) {
                              EasyLoading.dismiss();
                              setState(() {
                                final allPointCash = int.parse(_pro.userDetail['points'].toString()) / int.parse(_pro.config['points_per_cedi']);
                                if(allPointCash <= double.parse(_amount.text)){
                                  tempPoints =
                                      _pro.userDetail['points'].toString();
                                  _points.text = tempPoints;
                                }
                                else{
                                  final a  = (allPointCash -  double.parse(_amount.text)) * int.parse(_pro.config['points_per_cedi']);
                                  tempPoints = a.toString();
                                }

                              });
                            });
                          },
                          child: Card(
                            child: Container(
                                color: appColor,
                                height: 45,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                        child: Text(
                                      "APPLY ALL",
                                      style: TextStyle(color: Colors.white),
                                    )))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      textBaseline: TextBaseline.ideographic,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              tempPoints = "";
                            });
                          },
                          child: Card(
                            child: Container(
                                color: appColor,
                                height: 45,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                        child: Text(
                                      "Reset",
                                      style: TextStyle(color: Colors.white),
                                    )))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => offlinePayment(getTotal(
                          int.parse(_pro.userDetail['points'].toString()),
                          _pro.config['points_per_cedi'].toString())),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          color: appColor,
                          height: 50,
                          child: Center(
                            child: Text(
                                "PROCEED TO PAY - GHc ${getTotal(int.parse(_pro.userDetail['points'].toString()), _pro.config['points_per_cedi'].toString())}",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
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
        style: TextStyle(fontSize: 14, color: Colors.black38),
      ),
    );
  }
}
