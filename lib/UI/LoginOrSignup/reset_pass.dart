import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/style.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();

  var tap = 0;
  String _pin = "";

  Reset(pin) async {
    EasyLoading.show(status: "Processing");
    http.Response response = await http
        .post(Uri.parse(base_url + "general/password-change"), body: {
      "code": pin,
      "password": _pass.text,
      "confirm_password": _pass2.text
    });

    EasyLoading.dismiss();

    if (response.statusCode < 206) {
      EasyLoading.showSuccess(json.decode(response.body)['message']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginScreen()));
    } else {
      EasyLoading.showError(json.decode(response.body)['message']);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pass.dispose();
    _pass2.dispose();
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),

                              /// padding logo

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage("assets/img/Logo.png"),
                                    height: 70.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0)),

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
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12)
                                      ]),
                                  padding: EdgeInsets.only(
                                      left: 20.0,
                                      right: 30.0,
                                      top: 0.0,
                                      bottom: 0.0),
                                  child: Theme(
                                    data: ThemeData(
                                      hintColor: Colors.transparent,
                                    ),
                                    child: TextFormField(
                                      controller: _pass,
                                      validator: (e) {
                                        if (_pass.text.isEmpty) {
                                          return "Please enter password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Password",
                                          icon: Icon(
                                            Icons.vpn_key,
                                            color: Colors.black38,
                                          ),
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

                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12)
                                      ]),
                                  padding: EdgeInsets.only(
                                      left: 20.0,
                                      right: 30.0,
                                      top: 0.0,
                                      bottom: 0.0),
                                  child: Theme(
                                    data: ThemeData(
                                      hintColor: Colors.transparent,
                                    ),
                                    child: TextFormField(
                                      controller: _pass2,
                                      validator: (e) {
                                        if (_pass2.text.isEmpty) {
                                          return "Please enter password again";
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Confirm Password",
                                          icon: Icon(
                                            Icons.vpn_key,
                                            color: Colors.black38,
                                          ),
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

                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              Text(
                                "Enter Code",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              OTPTextField(
                                length: 4,
                                width: MediaQuery.of(context).size.width * 0.8,
                                fieldWidth: 40,
                                style: TextStyle(fontSize: 20),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.box,
                                keyboardType: TextInputType.text,
                                onCompleted: (pin) {
                                  setState(() {
                                    _pin = pin;
                                  });
                                },
                              ),

                              /// Button Signup

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
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.1,
                        right: 30,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.close),
                            ),
                          ),
                        )),

                    /// Set Animaion after user click buttonLogin
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: () {
                        setState(() {
                          tap = 1;
                        });
                        // new LoginAnimation(
                        //   animationController: sanimationController.view,
                        // );
                        // _PlayAnimation();
                        return tap;
                      },
                      child: TextButton(
                        onPressed: () => Reset(_pin),
                        child: buttonBlackBottom(
                          funct: Reset,
                        ),
                      ),
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

  buttonBlackBottom({this.funct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Reset",
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
    );
  }
}
