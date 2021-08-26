import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({Key key}) : super(key: key);

  @override
  _onBoardingState createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  String image ="assets/img/wc.jpg";


  void changePage()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('installed', true);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => bottomNavigationBar(),
      ),
          (Route<dynamic> route) => false,
    );
  }
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), changePage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: double.infinity,
        color: Colors.grey,
        child: Image.asset("assets/img/wc.jpg", fit: BoxFit.fill,),
      ),
    );
  }
}
