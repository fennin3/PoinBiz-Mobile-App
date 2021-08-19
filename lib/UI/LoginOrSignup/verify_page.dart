import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';


class VerifyPage extends StatefulWidget {
  const VerifyPage({Key key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> with TickerProviderStateMixin {
  AnimationController sanimationController;
  String signature="";
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  _signature()async{
    String signature = await SmsRetrieved.getAppSignature();
  }


  var tap = 0;

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }


  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      }else{
        _enableButton = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _signature();
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
                              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
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
                               Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0)),

                                    TextFieldPin(
                                      filled: true,
                                      filledColor: Colors.grey[100],
                                      codeLength: _otpCodeLength,
                                      boxSize: 48,
                                      onOtpCallback: (code, isAutofill) =>
                                          _onOtpCallBack(code, isAutofill),
                                    )

                                  ],
                                ),



                              /// Button Signup
                              FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                             loginScreen()));
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
