import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class PointTransfer extends StatefulWidget {
  const PointTransfer({Key key}) : super(key: key);

  @override
  _PointTransferState createState() => _PointTransferState();
}

class _PointTransferState extends State<PointTransfer> {
  final TextEditingController _receiverId = TextEditingController();
  final TextEditingController _points = TextEditingController();

  void transferPoints() async {
    EasyLoading.show(status: "Processing");
    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();

    final _data = {
      "sender_id": userId,
      "receiver_id": _receiverId.text,
      "points": _points.text
    };

    http.Response response = await http.post(
      Uri.parse(base_url + "user/points-transfer"),
      body: _data,
      headers: {HttpHeaders.authorizationHeader:"Bearer $userToken"}
    );
    EasyLoading.dismiss();
    if(response.statusCode < 205){
      EasyLoading.showSuccess("${json.decode(response.body)['message']}");
    }
    else{
      EasyLoading.showError("${json.decode(response.body)['message']}");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _receiverId.dispose();
    _points.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    _pro.getUserDetail();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "Point Transfer",
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
                child: Center(
                  child: Text(
                    "You Have \n${_pro.userDetail['points']} Points \n(GHc ${int.parse(_pro.userDetail['points'].toString()) / int.parse(_pro.config['points_per_cedi'])})",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                decoration: BoxDecoration(
                    color: appColor,
                    image: DecorationImage(
                        image: AssetImage("assets/img/point.jpg"),
                        fit: BoxFit.cover)),
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
                            controller: _receiverId,
                            validator: (e) {
                              if (_receiverId.text.isEmpty) {
                                return "Please enter receiver ID";
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
                                labelText: "Receiver ID",
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
                            controller: _points,
                            validator: (e) {
                              if (_points.text.isEmpty) {
                                return "Please enter point";
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
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: ()=>transferPoints(),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          color: appColor,
                          height: 50,
                          child: Center(
                            child: Text("TRANSFER",
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
