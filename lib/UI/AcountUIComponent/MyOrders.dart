import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/order_details.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class order extends StatefulWidget {
  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  List _openOrders = [];
  List _closedOrders = [];

  static var _txtCustom = TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  /// Create Big Circle for Data Order Not Success
  var _bigCircleNotYet = Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        shape: BoxShape.circle,
      ),
    ),
  );

  /// Create Circle for Data Order Success
  var _bigCircle = Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 14.0,
        ),
      ),
    ),
  );

  /// Create Small Circle
  var _smallCircle = Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 3.0,
      width: 3.0,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        shape: BoxShape.circle,
      ),
    ),
  );

  void updateOrderStatus(id, how) async {
    EasyLoading.show(status: "Processing");
    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    final _data = {
      "user_id": userId,
      "order_id": id,
      "action": how == "c" ? "cancelled" : "received"
    };

    http.Response response = await http.post(Uri.parse(base_url + "user/order-status"),
    body: _data,
      headers: {HttpHeaders.authorizationHeader: "Bearer $userToken"}
    );
    EasyLoading.dismiss();
    if(response.statusCode < 206){
      EasyLoading.showSuccess("${json.decode(response.body)['message']}");
    }else{
      EasyLoading.showError("${json.decode(response.body)['message']}");
    }

  }

  Future<void> _showMyDialog(id, who) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(who == 'c' ? 'Cancel Order' : 'Mark as Received'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(who == 'c'
                    ? 'Are you sure you want to cancel this order?'
                    : "This action means you have received the order"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Proceed'),
              onPressed: (){updateOrderStatus(id, who);
              Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    _pro.getOrders();
    setState(() {
      _openOrders = _pro.allorders
          .where((element) => element['status'].toString() != 'cancelled')
          .toList().reversed.toList();
      print(_openOrders.length);
      _closedOrders = _pro.allorders
          .where((element) => element['status'].toString() == 'cancelled')
          .toList();
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(241, 241, 241, 0.5),
        appBar: AppBar(
          title: Text(
            "My Orders",
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
          bottom: TabBar(
            indicatorColor: appColor,
            labelColor: appColor,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(icon: Text("Open Orders")),
              Tab(icon: Text("Closed Orders")),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            _openOrders.isNotEmpty
                ? ListView.builder(
                    itemCount: _openOrders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetail(
                                          data: _openOrders[index],
                                        )));
                          },
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order ID: ${_openOrders[index]['id']}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Total Amount:  GHc ${_openOrders[index]['amount']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                                "Point Used:  ${_openOrders[index]['points']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Unique Items:  ${_openOrders[index]['items'].length} Items",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Ordered:  ${_openOrders[index]['created']}",
                                                style: TextStyle(fontSize: 12)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "Updated:  ${_openOrders[index]['updated']}",
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                Text("Slide to edit <<<",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: appColor))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: _openOrders[index]
                                                                    ['status']
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "delivered"
                                                        ? Colors.lightGreen
                                                        : _openOrders[index]['status']
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                "pending"
                                                            ? Colors.grey
                                                            : _openOrders[index]['status']
                                                                        .toString()
                                                                        .toLowerCase() ==
                                                                    "processing"
                                                                ? Colors.blue
                                                                : _openOrders[index]['status']
                                                                            .toString()
                                                                            .toLowerCase() ==
                                                                        "on_delivery"
                                                                    ? Colors
                                                                        .yellow
                                                                    : _openOrders[index]['status'].toString().toLowerCase() ==
                                                                            "received"
                                                                        ? Colors
                                                                            .lightGreen
                                                                        : Colors
                                                                            .teal,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(2))),
                                                padding: EdgeInsets.all(3),
                                                child: Text(
                                                  "${_openOrders[index]['status']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Cancel',
                                color: Colors.red,
                                icon: Icons.close,
                                onTap: () => _showMyDialog(_openOrders[index]['id'], 'c'),
                              ),
                              IconSlideAction(
                                caption: 'Mark as received',
                                color: Colors.lightGreen,
                                icon: Icons.check,
                                onTap: () => _showMyDialog(_openOrders[index]['id'], 'd'),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text(
                      "You have no open order",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
            _closedOrders.isNotEmpty
                ? ListView.builder(
                    itemCount: _closedOrders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetail(
                                          data: _closedOrders[index],
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Total Amount:  GHc 1200",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Unique Items:  4 Items",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Ordered:  21-11-2021",
                                              style: TextStyle(fontSize: 12)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Slide to edit <<<",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: appColor))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(2))),
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                "Cancelled",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text(
                      "You have closed order",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

///Closed
//Padding(
//                     padding: const EdgeInsets.only(top: 10.0),
//                     child: Container(
//                         padding: EdgeInsets.all(10),
//                         height: 130,
//                         width: double.infinity,
//                         color: Colors.white,
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 120,
//                               width: 130,
//                               color: appColor,
//                             ),
//                             SizedBox(
//                               width: 15,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Apple 12 Pro Max. 512GB ROM & 12GB RAM",
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w800),
//                                       ),
//                                       SizedBox(
//                                         height: 2,
//                                       ),
//                                       Text("Order #2167367236",
//                                           style: TextStyle(fontSize: 13)),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey,
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(2))),
//                                         padding: EdgeInsets.all(3),
//                                         child: Text(
//                                           "CANCELLED - PAYMENT UNSUCCESSFUL",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 11),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 2,
//                                       ),
//                                       Text("On 21-11-2021",
//                                           style: TextStyle(fontSize: 12)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//
//                   );
