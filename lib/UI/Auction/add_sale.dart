import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/Components/add_auction_sale.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class AddAuction extends StatefulWidget {
  const AddAuction({Key key}) : super(key: key);

  @override
  _AddAuctionState createState() => _AddAuctionState();
}

class _AddAuctionState extends State<AddAuction> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "Add Auction Sale",
          style: auctionHeader,
        ),
        leading: TextButton(
            onPressed: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: SafeArea(
        child: AddAuctionSale(),
      ),
    );
  }
}
