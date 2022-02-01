import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/forgot_password.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/verify_page.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

/// Component Widget this layout UI
class _loginScreenState extends State<loginScreen>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var tap = 0;

  bool obsecure = true;

  void toggleObsecure() {
    obsecure = !obsecure;
  }

  void signin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    EasyLoading.show(status: "Signing In");
    final Map _data = {
      "user_id": _email.text,
      "password": _password.text,
      "type": "user"
    };

    try {
      http.Response response =
          await http.post(Uri.parse(base_url + "general/login"), body: _data);
      if (response.statusCode < 206) {
        if (response.statusCode == 202) {
          EasyLoading.dismiss();
          EasyLoading.showError("${json.decode(response.body)['message']}");
          Future.delayed(Duration(seconds: 2));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifyPage()));
        } else {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Login Successful");
          print(response.body);
          print(response.statusCode);
          sharedPreferences.setStringList("data", [
            json.decode(response.body)['token'],
            json.decode(response.body)['data']['id'],
          ]);

          sharedPreferences.setBool("loggedin", true);


          EasyLoading.dismiss();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => new bottomNavigationBar()));
        }
      } else {
        // EasyLoading.dismiss();
        EasyLoading.showInfo("${json.decode(response.body)['message']}",
            duration: Duration(seconds: 5));
        EasyLoading.dismiss();
      }
    } on SocketException {
      EasyLoading.showInfo("No internet connection");
      EasyLoading.dismiss();
    }
  }

  @override

  /// set state animation controller
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    super.dispose();
    sanimationController.dispose();
    _email.dispose();
    _password.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  /// Component Widget layout UI
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                    child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.topCenter,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
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

                              /// TextFromField Email
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0)),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
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
                                            controller: _email,
                                            validator: (e) {
                                              if (_email.text.isEmpty) {
                                                return "Please enter email or phone";
                                              }
                                              // else if(!_email.text.contains("@") || !_email.text.contains(".com")){
                                              //   return "Please enter a valid email address";
                                              // }
                                              else {
                                                return null;
                                              }
                                            },
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "Email or Phone",
                                                icon: Icon(
                                                  Icons.email,
                                                  color: Colors.black38,
                                                ),
                                                labelStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: 'Sans',
                                                    letterSpacing: 0.3,
                                                    color: Colors.black38,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// TextFromField Password
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.0)),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
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
                                              controller: _password,
                                              validator: (e) {
                                                if (_password.text.isEmpty) {
                                                  return "Please enter password";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              obscureText: true,
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
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              keyboardType: TextInputType.text,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPassword())),
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                            color: Color(0xFF121940),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans"),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              /// Button Signup
                              FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Signup()));
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Need an account? ",
                                        style: TextStyle(
                                            color: Color(0xFF121940),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans"),
                                        children: [
                                          TextSpan(
                                              text: " Sign Up",
                                              style: TextStyle(
                                                  color: Color(0xFF6E48AA),
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Sans"))
                                        ]),
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
                            child: buttonBlackBottom(
                              formKey: _formKey,
                              funct: signin,
                            ),
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

/// textfromfield custom class
class textFromField extends StatelessWidget {
  bool password;
  String email;
  IconData icon;
  TextInputType inputType;

  textFromField({this.email, this.icon, this.inputType, this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

///buttonCustomFacebook class
class buttonCustomFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(107, 112, 248, 1.0),
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/icon_facebook.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Facebook",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            ),
          ],
        ),
      ),
    );
  }
}

///buttonCustomGoogle class
class buttonCustomGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/google.png",
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(
              "Login With Google",
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            )
          ],
        ),
      ),
    );
  }
}

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  final formKey;
  final Function funct;

  buttonBlackBottom({this.formKey, this.funct});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          funct();
        } else {
          print("Not ontottnotnt");
        }
      },
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          height: 55.0,
          width: 600.0,
          child: Text(
            "Login",
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
