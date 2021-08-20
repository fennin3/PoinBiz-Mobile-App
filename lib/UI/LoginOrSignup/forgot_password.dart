import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  AnimationController sanimationController;

  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  var tap = 0;



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
                        top: MediaQuery.of(context).size.height *0.1,
                        right: 30,
                        child:

                    InkWell(
                      onTap: ()=>Navigator.pop(context),
                      child: Card(child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.close),
                      ),),
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
                      child: buttonBlackBottom(funct: (){},),
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
            "",
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

