import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/CartLayout.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Home.dart';
import 'package:provider/provider.dart';

class bottomNavigationBar extends StatefulWidget {

 @override
 _bottomNavigationBarState createState() => _bottomNavigationBarState();
}



class _bottomNavigationBarState extends State<bottomNavigationBar> {
 int currentIndex = 0;
 final GlobalKey<ScaffoldState> _key = GlobalKey();


 /// Set a type current number a layout class
 Widget callPage(int current) {
  switch (current) {
   case 0:
    return new Menu(scaKey: _key,);
   // case 1:
   //  return new brand();
   case 3:
    return new cart();
   case 2:
    return Menu();
    case 1:
      return Menu(scaKey: _key,);
    break;
   default:
    return Menu(scaKey: _key,);
  }
 }




 @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
 @override
 Widget build(BuildContext context) {
  return Scaffold(
    drawer: Drawer(

      child: Column(
        children: [
          DrawerHeader(
                decoration: BoxDecoration(color: const Color(0xFF6991C7)),
              child: Center(child: Text("App Logo"))),
          ExpansionTile(title: Text("Order Request"), leading: Icon(Icons.receipt_long_rounded),trailing: Icon(Icons.arrow_forward_ios), children: [
            
          ],),
          ExpansionTile(title: Text("Bidding Feature"), leading: Icon(Icons.local_offer),trailing: Icon(Icons.arrow_forward_ios)),


        ],
      )
    ),
    key: _key,
   body: callPage(currentIndex),
   bottomNavigationBar: Theme(
       data: Theme.of(context).copyWith(
           canvasColor: Colors.white,
           textTheme: Theme.of(context).textTheme.copyWith(
               caption: TextStyle(color: Colors.black26.withOpacity(0.15)))),
       child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        fixedColor: Color(0xFF6991C7),
        onTap: (value) {
         currentIndex = value;
         setState(() {});
        },
        items: [
         BottomNavigationBarItem(
             icon: Icon(
              Icons.shop,
              size: 23.0,
             ),
             title: Text(
              "Shop",
              style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
             )),
         // BottomNavigationBarItem(
         //     icon: Icon(Icons.search),
         //     title: Text(
         //      "Search",
         //      style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
         //     )),


         BottomNavigationBarItem(
             icon: Icon(
              Icons.directions_bus,
              size: 24.0,
             ),
             title: Text(
              "Bus",
              style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
             )),

          BottomNavigationBarItem(

              icon: Icon(Icons.event),

              title: Text(
                "Events",
                style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
              ),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                "Cart",
                style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
              )),
        ],
       )),
  );
 }
}

