import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Home.dart';

import 'flash_sell_items.dart';

class FlashSell extends StatelessWidget {
  final PoinBizProvider pro;
  FlashSell({this.pro});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      height: 390.0,
      decoration: BoxDecoration(
        /// To set Gradient in flashSale background
        gradient: LinearGradient(colors: [
          Color(0xFF7F7FD5).withOpacity(0.8),
          Color(0xFF86A8E7),
          Color(0xFF91EAE4)
        ]),
      ),

      /// To set FlashSale Scrolling horizontal
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.only(left: mediaQueryData.padding.left + 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/img/flashsaleicon.png",
                    height: mediaQueryData.size.height * 0.087,
                  ),
                  Text(
                    "Flash",
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Sale",
                    style: TextStyle(
                      fontFamily: "Sans",
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 30),
                  ),
                ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 40.0)),

          /// Get a component flashSaleItem class
          for (var item in pro.allpromos)
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: flashSaleItem(
                  id: item['id'].toString(),
                  image: item['image']['path'],
                  title: item['product']['name'],
                  normalprice: "Ghc ${item['product']['price']}",
                  discountprice: "GHc ${item['product']['discount_price']}",
                  // reviews: item['product']['reviews'],
                  place: "Ghana",
                  stock: item['product']['stock'].toString(),
                  colorLine: 0xFFFFA500,
                  widthLine: double.infinity,
                  duration: item['duration']),
            ),
        ],
      ),
    );
  }
}
