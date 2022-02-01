import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart' as http;
import 'package:treva_shop_flutter/UI/HomeUIComponent/DetailProduct.dart';
import 'package:treva_shop_flutter/constant.dart';

class flashSaleItem extends StatefulWidget {
  final String id;
  final String image;
  final String title;
  final String normalprice;
  final String discountprice;
  final List reviews;
  final String place;
  final String stock;
  final int colorLine;
  final double widthLine;
  final int duration;

  flashSaleItem(
      {this.id,
        this.image,
        this.title,
        this.normalprice,
        this.discountprice,
        this.reviews,
        this.place,
        this.stock,
        this.colorLine,
        this.widthLine,
        this.duration});

  @override
  State<flashSaleItem> createState() => _flashSaleItemState();
}

class _flashSaleItemState extends State<flashSaleItem> {
  double rate = 0;

  int calRate() {
    if (widget.reviews!= null && widget.reviews.length > 0) {
      for (var rev in widget.reviews) {
        setState(() {
          rate += double.parse(rev['rating'].toString());
        });
      }
    }else{
      setState(() {
        rate = 0;
      });
    }

    if (rate > 0) {
      setState(() {
        rate = rate / widget.reviews.length;
      });
    }
  }

  void getProd(context) async {
    EasyLoading.show(status: "Loading");
    http.Response response = await http
        .get(Uri.parse(base_url + "general/get-product/${widget.id}"));
    if (response.statusCode < 205) {
      EasyLoading.dismiss();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  detailProduk(json.decode(response.body)['data'])));
    } else {
      EasyLoading.dismiss();
      EasyLoading.showInfo("No internet connection");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calRate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                getProd(context);
              },
              child: Container(
                width: 145.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 140.0,
                      width: 145.0,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                      child: Text(widget.title,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(widget.normalprice,
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(widget.discountprice,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF7F7FD5),
                              fontWeight: FontWeight.w800,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          StarRating(
                            size: 18.0,
                            starCount: 5,
                            rating: rate,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$rate",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        widget.stock + " Available",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Sans",
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: Container(
                        height: 5.0,
                        width: widget.widthLine,
                        decoration: BoxDecoration(
                            color: Color(widget.colorLine),
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                            shape: BoxShape.rectangle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Sale ends in :",
                        style: TextStyle(
                          fontFamily: "Sans",
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                    ),

                    /// Get a countDown variable
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: Text(
                        "D" + ": " + "H" + " : " + "M " + ": " + "S",
                        style: TextStyle(
                          fontFamily: "Sans",
                          fontSize: 12.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: CountdownTimer(
                        endTime: widget.duration * 1000,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          if (time == null) {
                            return Text('Sale Ended');
                          }
                          return Text(
                              '${time.days ?? 0} : ${time.hours ?? 0} :  ${time.min ?? 0} : ${time.sec ?? 0}');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}