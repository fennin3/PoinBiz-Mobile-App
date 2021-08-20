import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/ListItem/CartItemData.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/Delivery.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/constant.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  final List<cartItem> items = [];

  @override
  void initState() {
    super.initState();
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
  }

  /// Declare price and value for chart
  int value = 1;
  int pay = 950;

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF6991C7)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Cart",
            style: TextStyle(
                fontFamily: "Gotik",
                fontSize: 18.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          elevation: 0.0,
        ),

        ///
        ///
        /// Checking item value of cart
        ///
        ///
        body: _pro.cart.length > 0
            ? Stack(
                children: [
                  ListView.builder(
                      itemCount: _pro.cart.length,
                      itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 1.0, left: 13.0, right: 13.0, bottom: 5),

                      /// Background Constructor for card
                      child: Container(
                        height: 220.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 3.5,
                              spreadRadius: 0.4,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(10.0),

                                    /// Image item
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12
                                                      .withOpacity(0.1),
                                                  blurRadius: 0.5,
                                                  spreadRadius: 0.1)
                                            ]),
                                        child: Image.file(
                                          File('${_pro.cart[position].image}'),
                                          height: 130.0,
                                          width: 120.0,
                                          fit: BoxFit.cover,
                                        ))),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0, left: 10.0, right: 5.0),
                                    child: Column(
                                      /// Text Information Item
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${_pro.cart[position].title}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Sans",
                                            color: Colors.black87,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Padding(padding: EdgeInsets.only(top: 10.0)),
                                        // Text(
                                        //   '${items[position].desc}',
                                        //   style: TextStyle(
                                        //     color: Colors.black54,
                                        //     fontWeight: FontWeight.w500,
                                        //     fontSize: 12.0,
                                        //   ),
                                        // ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(top: 10.0)),
                                        Text(
                                            'Ghc ${_pro.cart[position].price}'),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, left: 0.0),
                                              child: Container(
                                                width: 112.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    border: Border.all(
                                                        color: Colors.black12
                                                            .withOpacity(0.1))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    /// Decrease of value item
                                                    InkWell(
                                                      onTap: () {
                                                        _pro.updateSubItem(_pro
                                                            .cart[position]);
                                                      },
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                right: BorderSide(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0.1)))),
                                                        child: Center(
                                                            child: Text("-")),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18.0),
                                                      child: Text(_pro
                                                          .cart[position]
                                                          .quantity),
                                                    ),

                                                    /// Increasing value of item
                                                    InkWell(
                                                      onTap: () {
                                                        // _pro.updateaddCartItem(_pro.cart[position]);
                                                        _pro.updateAddItem(_pro
                                                            .cart[position]);
                                                      },
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 28.0,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                left: BorderSide(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0.1)))),
                                                        child: Center(
                                                            child: Text("+")),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () =>
                                                    _pro.removeCartItem(
                                                        _pro.cart[position]),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 28,
                                                  color: Color(0xFFA3BDED),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Divider(
                              height: 2.0,
                              color: Colors.black12,
                            ),
                            SizedBox(height: 10,),
                            Row(

                              children: [
                                SizedBox(width: 10,),
                                Text("Total: GHc ${int.parse(_pro.cart[position].price) * int.parse(_pro.cart[position].quantity)}")
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 8,
                    child: Card(
                      color: appColor,
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Total : Ghc " + _pro.getTotal().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.5,
                                fontFamily: "Sans"),
                          ),
                        ),
                      ),
                    )),
                  Positioned(
                    bottom: 10, right: 0,
                    child: InkWell(
                      onTap: () async{
                        SharedPreferences sharedpref = await SharedPreferences.getInstance();
                        final loggedIn = sharedpref.getBool('loggedin');

                        if(loggedIn){
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => delivery()));
                        }
                        else{
                          EasyLoading.showInfo("You have to log in to proceed");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFA3BDED),
                          ),
                          child: Center(
                            child: Text(
                              "Pay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),),

                ],
              )
            : noItemCart());
  }
}

///
///
/// If no item cart this class showing
///
class noItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "Your Cart Is Empty",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
