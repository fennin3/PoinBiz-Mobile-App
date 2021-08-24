import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderDetail extends StatelessWidget {
  final Map data;

  OrderDetail({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 241, 241, 0.5),
      appBar: AppBar(
        title: Text(
          "Order Detail",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: appColor,
            )),
        iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${data['id']}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Placed On:  ${data['created']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Number of Items: ${data['items'].length}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Total: GHc ${data['amount']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SectionTitle(
                text: "PAYMENT",
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${data['payment'].isEmpty ? "Unknown" : data['payment']['method']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Divider(),
                      Text(
                        "Payment Details",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Items total: GHc ${data['amount']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Shipping Fees: GHc null",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Total: GHc ${data['amount']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SectionTitle(
                text: "DELIVERY",
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Option",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Home Or Office Delivery",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Divider(),
                      Text(
                        "Home Or Office  Address",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${data['address']['region']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${data['address']['city']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${data['address']['address']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${data['address']['recipient']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${data['address']['recipient_number']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${data['address']['phone']}",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SectionTitle(
                text: "ITEMS IN YOUR ORDER",
              ),
              SizedBox(
                height: 2,
              ),
              Column(
                children: [
                  for (var item in data['items'])
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 140,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              color: appColor,
                              child: item["image"] != null
                                  ? Image.network(
                                      item['image'],
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text("QTY: ${item['quantity']}",
                                          style: TextStyle(fontSize: 13)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text("UNIT PRICE: ${item['price']}",
                                          style: TextStyle(fontSize: 12)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text("TOTAL PRICE: ${item['total']}",
                                          style: TextStyle(fontSize: 12)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "Color: ${item['variants']['color']}",
                                              style: TextStyle(fontSize: 12)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "Size: ${item['variants']['size']}",
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: data['status']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "delivered"
                                                  ? Colors.lightGreen
                                                  : data['status']
                                                              .toString()
                                                              .toLowerCase() ==
                                                          "pending"
                                                      ? Colors.grey
                                                      : data['status']
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              "processing"
                                                          ? Colors.blue
                                                          : data['status']
                                                                      .toString()
                                                                      .toLowerCase() ==
                                                                  "on_delivery"
                                                              ? Colors.yellow
                                                              : data['status']
                                                                          .toString()
                                                                          .toLowerCase() ==
                                                                      "received"
                                                                  ? Colors
                                                                      .lightGreen
                                                                  : Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            "${data['status']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          )),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text("On 21-11-2021",
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  SectionTitle({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "$text",
        style: TextStyle(color: Colors.black54, fontSize: 13),
      ),
    );
  }
}
