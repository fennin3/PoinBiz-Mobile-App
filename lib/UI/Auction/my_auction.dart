import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';

class MyAuctionSales extends StatefulWidget {
  const MyAuctionSales({Key key}) : super(key: key);

  @override
  _MyAuctionSalesState createState() => _MyAuctionSalesState();
}

class _MyAuctionSalesState extends State<MyAuctionSales> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "My Auction Sales",
          style: auctionHeader,
        ),
        leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 5,
            padding: EdgeInsets.only(top: 10, bottom: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  title: Text("Product name"),
                  subtitle: Text("Quantity: 10"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
