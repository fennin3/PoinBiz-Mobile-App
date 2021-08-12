import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/constant.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _othernames = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String _gender;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm_password = TextEditingController();

  var tap = 0;

  final _formKey = GlobalKey<FormState>();


  void signUp()async{
    EasyLoading.show(status: "Creating Account");
    final Map _data = {
      "first_name":_firstname.text,
      "password":_password.text,
      "confirm_password":_confirm_password.text,
      "gender":_gender,
      "other_names":_othernames.text,
      "email_address":_email.text,
      "phone_number":_phone.text
    };

    http.Response response = await http.post(Uri.parse(base_url+"user/signup"), body: _data);
    if(response.statusCode < 206){

      EasyLoading.showSuccess("${json.decode(response.body)['message']}", duration: Duration(seconds: 6));
      EasyLoading.dismiss();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => loginScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    }
    else{
      // EasyLoading.dismiss();
      EasyLoading.showInfo("${json.decode(response.body)['message']}");
      EasyLoading.dismiss();
    }

  }

  /// Set AnimationController to initState
  @override
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

  /// Dispose animationController
  @override
  void dispose() {
    super.dispose();
    sanimationController.dispose();
    _firstname.dispose();
    _othernames.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirm_password.dispose();
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
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              /// Set Background image in layout
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/img/backgroundgirl.png"),
                fit: BoxFit.cover,
              )),
              child: Container(
                /// Set gradient color in image
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.2),
                      Color.fromRGBO(0, 0, 0, 0.3)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),
                /// Set component layout
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextButton(
                                      onPressed: ()=>Navigator.pop(context),
                                      child: Card(child: Icon(Icons.close, color: Colors.black,),)),
                                ),
                              ],
                            ),
                            Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Column(
                                children: <Widget>[
                                  /// padding logo
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              mediaQueryData.padding.top + 25.0)),
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
                                      /// Animation text treva shop accept from login layout
                                      Hero(
                                        tag: "Treva",
                                        child: Text(
                                          "PoinBiz",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.6,
                                              fontFamily: "Sans",
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.0)),
                                  /// TextFromField Email


                                  Form(
                                    key: _formKey,
                                    child: Column(
                                    children: [
                                      ///FIRST NAME
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                              controller: _firstname,
                                              validator: (e){
                                                if(_firstname.text.isEmpty){
                                                  return "Please enter first name";
                                                }
                                                else{
                                                  return null;
                                                }
                                              },
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "First Name",
                                                  icon: Icon(
                                                    Icons.person,
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
                                          EdgeInsets.symmetric(vertical: 5.0)),


                                      ///OTHER NAMES
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                              controller: _othernames,
                                              validator: (e){
                                                if(_othernames.text.isEmpty){
                                                  return "Please enter other names";
                                                }
                                                else{
                                                  return null;
                                                }
                                              },
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Other Names",
                                                  icon: Icon(
                                                    Icons.person,
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
                                          EdgeInsets.symmetric(vertical: 5.0)),



                                      ///Email Address
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                              controller: _email,
                                              validator: (e){
                                                if(_email.text.isEmpty){
                                                  return "Please enter email";

                                                }
                                                else if (!_email.text.contains("@") || !_email.text.contains(".com")){
                                                  return "Please enter a valid email address";

                                                }
                                                else{
                                                  return null;
                                                }
                                              },
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Email",
                                                  icon: Icon(
                                                    Icons.email,
                                                    color: Colors.black38,
                                                  ),
                                                  labelStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: 'Sans',
                                                      letterSpacing: 0.3,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w600)),
                                              keyboardType: TextInputType.emailAddress,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 5.0)),


                                      ///Phone Address
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                              controller: _phone,
                                              validator: (e){
                                                if(_phone.text.isEmpty){
                                                  return "Please enter phone number";

                                                }

                                                else{
                                                  return null;
                                                }
                                              },
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Phone number",
                                                  icon: Icon(
                                                    Icons.phone_android,
                                                    color: Colors.black38,
                                                  ),
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
                                      Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 5.0)),


                                      ///Gender
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                DropdownButton<String>(
                                                  hint: Text("Select gender", style: TextStyle(fontSize: 15, color: Colors.black54)),
                                                  value: _gender,
                                                  // icon: const Icon(
                                                  //     Icons.arrow_drop_down),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                  underline: Container(
                                                    height: 2,
                                                    color: Colors.transparent,
                                                  ),
                                                  onChanged:
                                                      (String newValue) {
                                                    setState(() {
                                                      _gender =
                                                          newValue;
                                                    });
                                                  },
                                                  items: [
                                                    "Male",
                                                    "Female",
                                                  ].map<
                                                      DropdownMenuItem<
                                                          String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 5.0)),

                                      /// TextFromField Password

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                              controller: _password,
                                              validator: (e){
                                                if(_password.text.isEmpty){
                                                  return "Please enter password";
                                                }
                                                else{
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
                                                      fontWeight: FontWeight.w600)),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 5.0)),

                                      ///Confirm password
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Container(
                                          
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
                                              controller: _confirm_password,
                                              validator: (e){
                                                if(_password.text.isEmpty){
                                                  return "Please enter password";
                                                }
                                                else if(_password.text != _confirm_password.text){
                                                  return "Passwords do not match";
                                                }
                                                else{
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
                                                      fontWeight: FontWeight.w600)),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 5.0)),
                                    ],
                                    ),
                                  ),
                                  /// Button Login
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextButton(

                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      new loginScreen()));
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Have an account? ",
                                              style: TextStyle(
                                                  color: Color(0xFF121940),
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Sans"),
                                              children: [
                                                TextSpan(
                                                    text: " Sign In",
                                                    style: TextStyle(
                                                        color: Color(0xFF6E48AA),
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Sans")
                                                )
                                              ]
                                          ),

                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: mediaQueryData.padding.top + 90.0,
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
                                  _PlayAnimation();
                                  return tap;
                                },
                                child: buttonBlackBottom(func: signUp, formkey: _formKey,),
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
          ],
        ),
      ),
    );
  }
}

/// textfromfield custom class


///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  final formkey;
  final Function func;

  buttonBlackBottom({this.formkey, this.func});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        if(formkey.currentState.validate()){
          func();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          height: 55.0,
          width: 600.0,
          child: Text(
            "Sign Up",
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
