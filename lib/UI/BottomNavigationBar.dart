import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Components/add_auction_sale.dart';
import 'package:treva_shop_flutter/UI/Auction/add_sale.dart';
import 'package:treva_shop_flutter/UI/Auction/my_auction.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/CartLayout.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Home.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/UI/Vendor/all_venders.dart';

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
        return new Menu(
          scaKey: _key,
        );
      // case 1:
      //  return new brand();
      case 3:
        return new cart();
      case 2:
        return Menu();
      case 1:
        return Menu(
          scaKey: _key,
        );
        break;
      default:
        return Menu(
          scaKey: _key,
        );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context,listen: true);
    return Scaffold(
      drawer: MyDrawer(),
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
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.shopping_cart),
                      Positioned(
                          left: -12,
                          top: -7,
                          child: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.red,
                        child: Text(_pro.cart.length.toString()),
                      ))
                    ],
                  ),
                  title: Text(
                    "Cart",
                    style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                  )),
            ],
          )),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: const Color(0xFF6991C7)),
            child: Center(child: Text("App Logo"))),
        ExpansionTile(
          title: Text("Place Order"),
          leading: Icon(Icons.receipt_long_rounded),
          trailing: Icon(Icons.arrow_forward_ios),
          children: [
            ListTile(
              leading: Icon(Icons.add_shopping_cart_sharp),
              title: Text("Add Order"),
            ),
            ListTile(
              leading: Icon(
                Icons.inventory_outlined,
              ),
              title: Text("Ordered Requests"),
            )
          ],
        ),
        ExpansionTile(
          title: Text("Auction Sale"),
          leading: Icon(Icons.local_offer),
          trailing: Icon(Icons.arrow_forward_ios),
          children: [
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAuction()));
                },
              leading: Icon(Icons.price_change),
              title: Text("Add Auction Sale"),
            ),
            ListTile(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAuctionSales())),
              leading: Icon(Icons.local_offer),
              title: Text("My Auction Sales"),
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text("Vendors"),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AllVendors())),
        ),
      ],
    ));
  }
}


showAddAuctionSaleModal(context){
  showModalBottomSheet(
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
    ),
    isScrollControlled: true,
      context: context, builder: (context){
    return AddAuctionSale();
  });
}
