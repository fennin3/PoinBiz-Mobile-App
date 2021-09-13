import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/AboutApps.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/CallCenter.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/Message.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/CreditCardSetting.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/MyOrders.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/Notification.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/SettingAcount.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:provider/provider.dart';

class profil extends StatefulWidget {
  @override
  _profilState createState() => _profilState();
}

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Name User
var _txtName = _txt.copyWith(fontWeight: FontWeight.w700, fontSize: 17.0);

/// Get _txt and custom value of Variable for Edit text
var _txtEdit = _txt.copyWith(color: Colors.black26, fontSize: 15.0);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(
    fontSize: 14.5, color: Colors.black54, fontWeight: FontWeight.w500);

class _profilState extends State<profil> {
  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);


    var _profile = Padding(
      padding:  EdgeInsets.only(top: 185.0, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(

          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(_pro.userDetail['avatar']['path']))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "${_pro.userDetail['name']}",
                style: _txtName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Text(
                "${_pro.userDetail['email']}",
                style: _txtName.copyWith(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Text(
                "${_pro.userDetail['phone']}",
                style: _txtName.copyWith(fontSize: 15),
              ),
            ),
            // InkWell(
            //   onTap: null,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10.0),
            //     child: Text(
            //       "Edit Profile",
            //       style: _txtEdit,
            //     ),
            //   ),
            // ),
          ],
        ),
        Container(

        ),
      ],
      ),
    );

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                /// Setting Header Banner
                Stack(
                  children: [
                    Container(
                      height: 240.0,
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text("Your Point\n${_pro.userDetail['points']}\nGHc ${int.parse(_pro.userDetail['points'].toString()) / int.parse(_pro.config['points_per_cedi'])} ",textAlign: TextAlign.center, style: TextStyle(fontSize: 30,color: Colors.black, fontWeight: FontWeight.w800),)),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/headerProfile.png"),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        top: 6,
                        right: 6,
                        child: TextButton(
                          onPressed: ()=>Navigator.pop(context),
                          child: Card(child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.close, color: Color(0xFF6991C7),size: 25,),
                    ),),
                        ))
                  ],
                ),
                /// Calling _profile variable
                _profile,
                Padding(
                  padding: const EdgeInsets.only(top: 380.0),
                  child: Column(
                    /// Setting Category List
                    children: <Widget>[
                      /// Call category class
                      category(
                        txt: "Notification",
                        padding: 35.0,
                        image: "assets/icon/notification.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new notification()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      // category(
                      //   txt: "Payments",
                      //   padding: 35.0,
                      //   image: "assets/icon/creditAcount.png",
                      //   tap: () {
                      //     Navigator.of(context).push(PageRouteBuilder(
                      //         pageBuilder: (_, __, ___) =>
                      //             new creditCardSetting()));
                      //   },
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 20.0, left: 85.0, right: 30.0),
                      //   child: Divider(
                      //     color: Colors.black12,
                      //     height: 2.0,
                      //   ),
                      // ),
                      // category(
                      //   txt: "Message",
                      //   padding: 26.0,
                      //   image: "assets/icon/chat.png",
                      //   tap: () {
                      //     Navigator.of(context).push(PageRouteBuilder(
                      //         pageBuilder: (_, __, ___) => new chat()));
                      //   },
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 20.0, left: 85.0, right: 30.0),
                      //   child: Divider(
                      //     color: Colors.black12,
                      //     height: 2.0,
                      //   ),
                      // ),
                      category(
                        txt: "My Orders",
                        padding: 23.0,
                        image: "assets/icon/truck.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new order()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: "Setting Acount",
                        padding: 30.0,
                        image: "assets/icon/setting.png",
                        tap: () {
                          // Navigator.of(context).push(PageRouteBuilder(
                          //     pageBuilder: (_, __, ___) => new settingAcount()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: "Call Center",
                        padding: 30.0,
                        image: "assets/icon/callcenter.png",
                        tap: () {
                          // Navigator.of(context).push(PageRouteBuilder(
                          //     pageBuilder: (_, __, ___) => new callCenter()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        padding: 38.0,
                        txt: "About Apps",
                        image: "assets/icon/aboutapp.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new aboutApps()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),

                      category(
                          padding: 38.0,
                          txt: "Logout ",
                          // image: "assets/icon/aboutapp.png",
                          tap: ()async{
                            EasyLoading.showInfo("Logging Out");
                            SharedPreferences sharedpref = await SharedPreferences.getInstance();
                            sharedpref.remove("loggedin");
                            sharedpref.remove("data");
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        bottomNavigationBar()));
                            EasyLoading.dismiss();
                          }
                        ),

                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: image != null ? Image.asset(
                    image,
                    height: 25.0,
                  ):Icon(Icons.logout, color: Colors.deepPurple,),
                ),
                Text(
                  txt,
                  style: _txtCategory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
