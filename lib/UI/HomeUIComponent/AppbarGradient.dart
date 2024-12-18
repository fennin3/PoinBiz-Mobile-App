import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/Profile.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/ChoseLoginOrSignup.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/constant.dart';
class AppbarGradient extends StatefulWidget {
  final scaKey;
  AppbarGradient({@required this.scaKey});
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient> {
  String CountNotice = "4";

    /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    void _getInitData() {
      final _pro = Provider.of<PoinBizProvider>(context, listen: false);
      _pro.getCartItem();
      _pro.getCartData();
      _pro.getWishListData();
      _pro.getOrders();
      _pro.getUserDetail();
      _pro.getPlacedOrders();
      try{
        _pro.getAddresses();
      }
      catch(e){}
      try{
        _pro.getUserDetail();
      }catch(e){}
    }
    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    /// Create component in appbar
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: media.size.height * 0.065,
     color: appColor,
      child: Row(
        textBaseline: TextBaseline.ideographic,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// if user click shape white in appbar navigate to search layout
          InkWell(
            onTap: () {
              if(_pro.allProducts != null)
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => searchAppbar(data: {"products":_pro.allProducts},),
                  /// transtation duration in animation
                  transitionDuration: Duration(milliseconds: 750),
                  /// animation route to search layout
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            },
            /// Create shape background white in appbar (background treva shop text)
            child: Container(
              margin: EdgeInsets.only(left: media.padding.left + 15),
              height: 37.0,
              width: 222.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  shape: BoxShape.rectangle),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 17.0)),
                  Image.asset(
                    "assets/img/search2.png",
                    height: 22.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    left: 17.0,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "PoinBiz",
                      style: TextStyle(
                          fontFamily: "Popins",
                          color: Colors.black12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.0,
                          fontSize: 16.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                    onTap: () async{
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      final value = sharedPreferences.getBool("loggedin");
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => value != null ? profil() : ChoseLogin())).then((value) => _getInitData());
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 26,color: Colors.white,),
                        Text("Account", style: TextStyle(fontSize: 14, color: Colors.white),)
                      ],
                    )



                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                    onTap: () {
                      widget.scaKey.currentState.openDrawer();
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.more_horiz, size: 26,color: Colors.white,),
                        Text("More", style: TextStyle(fontSize: 14, color: Colors.white),)
                      ],
                    )



                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
