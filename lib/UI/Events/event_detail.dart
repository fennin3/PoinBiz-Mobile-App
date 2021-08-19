import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Components/fav_widget.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:provider/provider.dart';

class EventCat extends StatefulWidget {
  const EventCat({Key key}) : super(key: key);

  @override
  _EventCatState createState() => _EventCatState();
}

class _EventCatState extends State<EventCat> {
  final GlobalKey _key = GlobalKey<ScaffoldState>();
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
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
                        )
                      ],
                    ),
                  ),
                  Positioned(right: 20, bottom: 20, child: FavWidget())
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Children's Museum of Atlanta",
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
                            Text("22 August, 2021")
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
                            Text("8:00 PM")
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
                            Text("Tema Community 9")
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
                      "ahh d ch hccd cd cdhchs dcsbccjd dhchs cbaub ccbbkcbac cbd buiab ciusc hhjbcbas ahbsj hc jsc jc ja icukbc bd hcd hsd ahsha hsa hs hsj xscjhsc dcbd bccjcbac chbasjhc",
                      expandText: "show more",
                      collapseText: "show less",
                      maxLines: 4,
                    ),

                    SizedBox(height: 20,),
                    Text(
                      "Ticket Type",
                      style: auctionHeader.copyWith(
                          color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    InkWell(
                        onTap: (){
                          setState(() {
                            _ticketNum = 0;
                          });
                        },
                        child: TicketWidget(text: "Standard - GHc 300", index: 0, nu: _ticketNum,)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            _ticketNum = 1;
                          });
                        },
                        child: TicketWidget(text: "VIP - GHc 500", index: 1, nu: _ticketNum,)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            _ticketNum = 2;
                          });
                        },
                        child: TicketWidget(text: "VVIP - GHc 300", index: 2, nu: _ticketNum,)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _ticketNum == null? Colors.grey: appColor,
        onPressed: (){
          if(_ticketNum == null){
            EasyLoading.showInfo("Please select ticket type");
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

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)

        ),
        child: Container(
            height: index==nu ?80: 70,
            decoration: BoxDecoration(
              color: index==nu ? Colors.white:Colors.black12,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Image.asset("assets/img/ticket2.png",
                  height: 30,
                ),
                SizedBox(width: 10,),
                Text(text)
              ],
            )
        ),
      ),
    );
  }
}


