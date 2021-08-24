import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/OrderRequest/add_order.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyOrder extends StatefulWidget {
  const MyOrder({Key key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  void updateProductRequest(final id, action) async {
    EasyLoading.show(status: "Sending request");

    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();
    final _data = {
      "user_id": userId,
      "request_id": id.toString(),
      "action": action == 'c' ? "cancelled" : "delete"
    };
    http.Response response = await http.post(
        Uri.parse(base_url + "user/update-request"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $userToken"},
        body: _data);
    EasyLoading.dismiss();
    if (response.statusCode < 206) {
      EasyLoading.showSuccess(json.decode(response.body)['message']);
    } else {
      EasyLoading.showError(json.decode(response.body)['message']);
    }
  }

  Future<void> _showMyDialog(id, who) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(who == 'c' ? 'Cancel Order' : 'Delete Order'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(who == 'c'
                    ? 'Are you sure you want to cancel this order?'
                    : "This action will delete the order request"),
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
              onPressed: () {
                Navigator.pop(context);
                updateProductRequest(id, 'who');
              },
            ),
          ],
        );
      },
    );
  }

  List placedSpecialOrders = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    _pro.getPlacedOrders();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    _pro.getPlacedOrders();
    placedSpecialOrders = _pro.placedOrders.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "My Special order requests",
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
        child: _pro.placedOrders.isEmpty? Center(child: Text("You have no special order request", style: TextStyle(fontSize: 25, ),),):  ListView.builder(
            itemCount: _pro.placedOrders.length,
            padding: EdgeInsets.only(top: 10, bottom: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(
                      // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionDetail())),
                      title: Text(
                        placedSpecialOrders[index]['name'],
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        placedSpecialOrders[index]['created'],
                        style: TextStyle(fontSize: 14),
                      ),
                      leading: Hero(
                        tag: "hero-grid-$index",
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return new Material(
                                      color: Colors.black54,
                                      child: Container(
                                        padding: EdgeInsets.all(30.0),
                                        child: Stack(
                                          children: [
                                            Hero(
                                                tag: "hero-grid-$index",
                                                child:placedSpecialOrders[index]['image'].toString() != 'false' && placedSpecialOrders[index]['image'].isNotEmpty ? Image.network(placedSpecialOrders[index]['image']['path'])  : Image.asset(
                                                  "assets/img/Logo.png",
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.cover,
                                                )),
                                            Positioned(
                                                right: 10,
                                                top: 10,
                                                child: TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  transitionDuration:
                                      Duration(milliseconds: 500)));
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:placedSpecialOrders[index]['image'].toString() != 'false' && placedSpecialOrders[index]['image'].isNotEmpty ? NetworkImage(placedSpecialOrders[index]['image']['path'])  :
                                  AssetImage("assets/img/Logo.png"),
                            ),
                          ),
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          placedSpecialOrders[index]['status']
                                      .toString()
                                      .toLowerCase() ==
                                  "pending"
                              ? Tooltip(
                                  message: "Pending response",
                                  child: Icon(Icons.pending_actions, size: 30,))
                              : placedSpecialOrders[index]['status']
                                          .toString()
                                          .toLowerCase() ==
                                      "cancelled"
                                  ? Tooltip(
                                      message: "Cancelled",
                                      child: Icon(
                                        Icons.close, size: 30,
                                        color: Colors.red,
                                      ))
                                  : Tooltip(
                                      message: "Responded, check your email or sms",
                                      child: Icon(
                                        Icons.done_all_sharp,size: 30,
                                        color: Colors.green,
                                      )),
                          Text(
                            "Slide to edit <<<",
                            style: TextStyle(fontSize: 11, color: appColor),
                          )
                        ],
                      )),
                  secondaryActions: <Widget>[
                    if(placedSpecialOrders[index]['status']
                        .toString()
                        .toLowerCase() ==
                        "pending")

                    IconSlideAction(
                      caption: 'Cancel',
                      color: appColor,
                      icon: Icons.close,
                      onTap: () =>
                          _showMyDialog(placedSpecialOrders[index]['id'], "c"),
                    ),
                    if(placedSpecialOrders[index]['status']
                        .toString()
                        .toLowerCase() !=
                        "pending"
                        )
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () =>
                          _showMyDialog(placedSpecialOrders[index]['id'], "d"),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddOrder(),
          ),
        ),
        backgroundColor: appColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
