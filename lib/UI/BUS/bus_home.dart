import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List busData = [];

  String _from = "";
  String _to = "";

  /// Create Big Circle for Data Order Not Success
  ///

  initData() {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    setState(() {
      busData = _pro.allbuses;
    });

    print("busdate = $busData");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);

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

    return _pro.allbuses.isNotEmpty
        ? SafeArea(
            child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: mediaQueryData.padding.top + 38.5)),
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
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              _bigCircleNotYet,
                              _smallCircle,
                              _smallCircle,
                              _smallCircle,
                              _smallCircle,
                              _bigCircle,
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownSearch<String>(
                                  mode: Mode.BOTTOM_SHEET,
                                  showSelectedItem: true,
                                  dropdownSearchBaseStyle:
                                      TextStyle(fontSize: 14),

                                  showSearchBox: true,

                                  isFilteredOnline: false,

                                  items: [
                                    'None',
                                    for (var dest in _pro.alldestinations)
                                      if (dest['name'] != _to) dest['name']
                                  ],
                                  label: "From",
                                  hint:
                                      "Select where you are travelling from...",
                                  // popupItemDisabled: (String s) => s.startsWith('I'),
                                  onChanged: (e) {
                                    setState(() {
                                      busData = _pro.allbuses;

                                      _from = e;
                                      if (_from != 'None')
                                        busData = _pro.allbuses
                                            .where((element) => element['from']
                                                    ['name']
                                                .toString()
                                                .contains(_from))
                                            .toList();

                                      if (_to != 'None') {
                                        busData = busData
                                            .where((element) => element['to']
                                                    ['name']
                                                .toString()
                                                .contains(_to))
                                            .toList();
                                      }
                                    });
                                  },
                                ),
                                Padding(padding: EdgeInsets.only(top: 20.0)),
                                DropdownSearch<String>(
                                  mode: Mode.BOTTOM_SHEET,
                                  showSelectedItem: true,
                                  dropdownSearchBaseStyle:
                                      TextStyle(fontSize: 14),
                                  showSearchBox: true,
                                  isFilteredOnline: true,
                                  items: [
                                    'None',
                                    for (var dest in _pro.alldestinations)
                                      if (dest['name'] != _from) dest['name']
                                  ],
                                  label: "To",
                                  hint: "Select where you are travelling to...",
                                  onChanged: (e) {
                                    setState(() {
                                      busData = _pro.allbuses;

                                      _to = e;

                                      if (_to != 'None')
                                        busData = busData
                                            .where((element) => element['to']
                                                    ['name']
                                                .toString()
                                                .contains(_to))
                                            .toList();
                                      if (_from != 'None') {
                                        busData = busData
                                            .where((element) => element['from']
                                                    ['name']
                                                .toString()
                                                .contains(_from))
                                            .toList();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (var route in busData)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      route['merchant']['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Text(
                                      "GHc ${route['amount']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(route['from'].isNotEmpty ?
                                    "${route['from']['name']}  -  ${route['to']['name']}": "  -  ${route['to']['name']}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _pro.addToCart({
                                          "quantity": "1",
                                          "price": route['amount'].toString(),
                                          "image": "ticket",
                                          "title": route['merchant']['name'],
                                          "color": "",
                                          "id": route['id'].toString(),
                                          "size": "",
                                          "store_id": route['store_id'],
                                          "total": route['amount'].toString()
                                        }, _scaffoldKey, "offline");
                                      },
                                      child: Card(
                                        color: appColor,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Add to cart",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.add_shopping_cart,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.departure_board,
                                          color: appColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("${route['departure']}")
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
          ))
        : noItemCart();
  }
}

class noItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
          Image.asset(
            "assets/imgIllustration/IlustrasiCart.png",
            height: 300.0,
          ),
          Padding(padding: EdgeInsets.only(bottom: 10.0)),
          Text(
            "No Buses Available At The Moment",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18.5,
                color: Colors.black26.withOpacity(0.2),
                fontFamily: "Popins"),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Checking"),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
