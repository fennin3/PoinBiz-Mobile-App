import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'dart:convert';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field/otp_text_field.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> with TickerProviderStateMixin {
  AnimationController sanimationController;

  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  var tap = 0;



  void _resendCode()async{
    EasyLoading.show(status: "Resending Code");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final phone = sharedPreferences.getString("phone");

    Map _data = {
      "phone_number":phone,
      "type":"user"
    };
    
    
    http.Response response = await http.post(Uri.parse(base_url +"general/resend-code"), body: _data);
    EasyLoading.dismiss();
    if(response.statusCode < 206){
      EasyLoading.showInfo("${json.decode(response.body)['message']}");
    }else{
      EasyLoading.showError("${json.decode(response.body)['message']}");
    }

  }


  void _verify(String code)async{
    EasyLoading.show(status: "Verifying Account");
    Map _data = {
      "code":code,
    };
    http.Response response = await http.post(Uri.parse(base_url +"general/verify-account"), body: _data);
    EasyLoading.dismiss();
    if (response.statusCode< 206){
      EasyLoading.showSuccess("${json.decode(response.body)['message']}");
      EasyLoading.dismiss();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => loginScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    }
    else{
      EasyLoading.showError("${json.decode(response.body)['message']}");
    }

  }






  @override
  void initState() {
    // TODO: implement initState
    sanimationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 800))
      ..addStatusListener((statuss) {
        if (statuss == AnimationStatus.dismissed) {
          setState(() {
            tap = 0;
          });
        }
      });
    super.initState();
  }

  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/loginscreenbackground.png"),
              fit: BoxFit.cover,
            )),
        child: SafeArea(
          child: Container(
            /// Set gradient color in image (Click to open code)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.0),
                  Color.fromRGBO(0, 0, 0, 0.3)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            /// Set component layout
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(

                      children: <Widget>[

                        Container(
                          alignment: AlignmentDirectional.topCenter,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                              /// padding logo

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage("assets/img/Logo.png"),
                                    height: 70.0,
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0)),

                                  /// Animation text treva shop accept from signup layout (Click to open code)
                                  Hero(
                                    tag: "Treva",
                                    child: Text(
                                      "PoinBiz",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.6,
                                          color: Colors.white,
                                          fontFamily: "Sans",
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),

                              /// ButtonCustomFacebook
                              // Padding(
                              //     padding: EdgeInsets.symmetric(vertical: 30.0)),
                              // buttonCustomFacebook(),

                              /// ButtonCustomGoogle
                              // Padding(
                              //     padding: EdgeInsets.symmetric(vertical: 7.0)),
                              // buttonCustomGoogle(),
                              /// Set Text
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0)),


                              /// TextFromField Email

                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0)),
                                    OTPTextField(
                                      length: 4,

                                      width: MediaQuery.of(context).size.width * 0.8,
                                      fieldWidth: 40,
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                      textFieldAlignment: MainAxisAlignment.spaceAround,
                                      fieldStyle: FieldStyle.box,
                                      keyboardType: TextInputType.text,
                                      onCompleted: (pin) {
                                        _verify(pin);
                                      },
                                    ),


                              /// Button Signup
                              FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    _resendCode();
                                  },


                                  child: RichText(
                                    text: TextSpan(
                                        text: "Resend Code ? ",
                                        style: TextStyle(
                                            color: Color(0xFF121940),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans"),
                                        children: [

                                        ]
                                    ),

                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: mediaQueryData.padding.top + 100.0,
                                    bottom: 0.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    /// Set Animaion after user click buttonLogin
                    tap == 0
                        ? InkWell(
                      splashColor: Colors.yellow,
                      onTap: () {
                        setState(() {
                          tap = 1;
                        });
                        new LoginAnimation(
                          animationController: sanimationController.view,
                        );
                        _PlayAnimation();
                        return tap;
                      },
                      child: buttonBlackBottom(funct: (){},),
                    )
                        : new LoginAnimation(
                      animationController: sanimationController.view,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class buttonBlackBottom extends StatelessWidget {
  final Function funct;
  buttonBlackBottom({ this.funct});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
          funct();
      },
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          height: 55.0,
          width: 600.0,
          child: Text(
            "Verify",
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.2,
                fontFamily: "Sans",
                fontSize: 18.0,
                fontWeight: FontWeight.w800),
          ),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                  colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
        ),
      ),
    );
  }
}
