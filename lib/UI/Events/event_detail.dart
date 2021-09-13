import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Components/fav_widget.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/CartLayout.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:provider/provider.dart';

class EventCat extends StatefulWidget {
  final Map data;

  EventCat({this.data});

  @override
  _EventCatState createState() => _EventCatState();
}

class _EventCatState extends State<EventCat> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _radioCon;
  int _ticketNum;

  @override
  Widget build(BuildContext context) {

    final _pro = Provider.of<PoinBizProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: appColor,
                    child: Image.network(
                      widget.data['image']['path'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Card(
                              color: appColor,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: InkWell(

                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>cart(),)),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Card(
                                  color: appColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: -8,
                                    top: -7,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                      child: Text("${_pro.cart.length}"),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Positioned(right: 20, bottom: 20, child: FavWidget())
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.data['name']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sans",
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              color: appColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.data['date'].toString().split("at ")[0])
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 20,
                              color: appColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.data['date'].toString().split("at ")[1])
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: appColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.data['venue'])
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Description",
                      style: auctionHeader.copyWith(
                          color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpandableText(
                      widget.data['description'],
                      expandText: "show more",
                      collapseText: "show less",
                      maxLines: 4,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    ///Work on Tickets
                    Text(
                      "Ticket Type",
                      style: auctionHeader.copyWith(
                          color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (var ticket in widget.data['tickets'])
                      InkWell(
                          onTap: () {
                            setState(() {
                              print(ticket['id']);
                              _ticketNum =
                                  widget.data['tickets'].indexOf(ticket);
                            });
                          },
                          child: TicketWidget(
                            text:
                                "${ticket['type']['name']} - GHc ${ticket['amount']}",
                            index: widget.data['tickets'].indexOf(ticket),
                            nu: _ticketNum,
                          )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _ticketNum == null ? Colors.grey : appColor,
        onPressed: () {
          if (_ticketNum == null) {
            EasyLoading.showInfo("Please select ticket type");
          } else {
            _pro.addToCart({
              "quantity": "1",
              "price": widget.data['tickets'][_ticketNum]['amount'],
              "image": widget.data['image']['path'],
              "title": widget.data['name'],
              "color": "",
              "id": widget.data['id'],
              "size": "",
              "store_id": widget.data['store_id'],
              "total": widget.data['amount'],
              "url": widget.data['link'],
              "current_stock": "",
              "shipping_cost": "",
              "shipping_type": "",
              "type": 'event'
            }, _scaffoldKey,"offline");
          }
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  final String text;
  final int index;
  final int nu;

  TicketWidget({this.text, this.index, this.nu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            height: index == nu ? 80 : 70,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/img/ticket2.png",
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(text)
              ],
            )),
      ),
    );
  }
}
