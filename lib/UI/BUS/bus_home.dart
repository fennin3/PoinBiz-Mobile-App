import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/MyOrders.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:dropdown_search/dropdown_search.dart';

class BusHome extends StatefulWidget {
  final scaKey;

  BusHome({this.scaKey});

  @override
  _BusHomeState createState() => _BusHomeState();
}

class _BusHomeState extends State<BusHome> {
  static var _txtCustom = TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  /// Create Big Circle for Data Order Not Success

  @override
  Widget build(BuildContext context) {
    var _bigCircleNotYet = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Icon(
          Icons.near_me,
          color: appColor,
        ),
      ),
    );

    /// Create Circle for Data Order Success
    var _bigCircle = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Icon(
          Icons.place,
          color: appColor,
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

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(top: mediaQueryData.padding.top + 38.5)),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Choose your journey",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        _bigCircleNotYet,
                        _smallCircle,


                        _smallCircle,
                        _smallCircle,
                        _smallCircle,
                        _bigCircle,
                      ],
                    ),
                    SizedBox(width: 10,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownSearch<String>(

                            mode: Mode.BOTTOM_SHEET,
                            showSelectedItem: true,
                            dropdownSearchBaseStyle: TextStyle(fontSize: 14),

                            showSearchBox: true,

                            isFilteredOnline: true,
                            showClearButton: true,

                            items: [
                              "Brazil",
                              "Italia",
                              "Tunisia",
                              "Canada",
                              "Brazil",
                              "Italia",
                              "Tunisia",
                              "Canada"
                            ],
                            label: "From",
                            hint: "Select where you are travelling from...",
                            // popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: (e) {
                              print(e);
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          DropdownSearch<String>(

                            mode: Mode.BOTTOM_SHEET,
                            showSelectedItem: true,
                            dropdownSearchBaseStyle: TextStyle(fontSize: 14),

                            showSearchBox: true,

                            isFilteredOnline: true,
                            showClearButton: true,

                            items: [
                              "Brazil",
                              "Italia",
                              "Tunisia",
                              "Canada",
                              "Brazil",
                              "Italia",
                              "Tunisia",
                              "Canada"
                            ],
                            label: "To",
                            hint: "Select where you are travelling to...",
                            // popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: (e) {
                              print(e);
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              for (var i in [1,2,3,4,5,6,7,8,9])
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child:
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),

                          ),
                          width: double.infinity,


                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("PoinBiz Express", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                  Text("GHc 125", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Cape Coast  -  Accra"),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: appColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                      child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.departure_board, color: appColor,),
                                      SizedBox(width: 10,),
                                      Text("7:30 PM")
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                )
            ],
          ),
        ),
        AppbarGradient(scaKey: widget.scaKey)
      ],
    ));
  }
}
