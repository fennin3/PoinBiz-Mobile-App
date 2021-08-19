import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/Events/event_category.dart';
import 'package:treva_shop_flutter/UI/Events/event_detail.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:treva_shop_flutter/constant.dart';

class EventHome extends StatefulWidget {
  final scaKey;

  EventHome({this.scaKey});

  @override
  _EventHomeState createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  @override
  Widget build(BuildContext context) {
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
                      EdgeInsets.only(top: mediaQueryData.padding.top + 45.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Available Event",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w700),
                      )),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //     child: Text(
                  //       "See all >>",
                  //       style: TextStyle(
                  //           color: appColor,
                  //           fontSize: 14.0,
                  //           fontFamily: "Sans",
                  //           fontWeight: FontWeight.w500),
                  //     )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i in [1, 2, 3])
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                        child: InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EventCategory())),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  height: 135,
                                  child: Image.asset(
                                    "assets/imgItem/category5.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Event Name",
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.1))),
                            width: 240,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "This Weekend",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w700),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "See all >>",
                        style: TextStyle(
                            color: appColor,
                            fontSize: 14.0,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20),
                child: TextButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EventCat())),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              height: 180,
                              child: Image.asset(
                                "assets/imgItem/category5.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(

                                bottom: -20,
                                left: 15,
                                child: Card(
                                elevation: 5,
                                child:Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Text("04", style: TextStyle(
                                          fontFamily: "Sans",
                                          fontSize: 14,
                                          color: appColor,
                                          fontWeight: FontWeight.bold),),
                                      Text("August", style: TextStyle(
                                          fontFamily: "Sans",
                                          fontSize: 14,
                                          color: appColor,
                                          fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Event Name",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Tema Community 9",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  fontSize: 13,
                                  ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                "07:30 PM",
                                style: TextStyle(
                                  fontFamily: "Sans",
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "From Ghc 30",
                                style: TextStyle(
                                  fontFamily: "Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              )


                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(6)),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.1))),
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

// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// width: size.width * 0.8,
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black.withOpacity(0.15))
// ),
// child: Row(
// children: [
// Icon(Icons.search, size: 18,),
// SizedBox(width: 13,),
// Flexible(child: TextField(
//
// decoration: InputDecoration(
// contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
// hintText: "Find Event ....",
// hintStyle: TextStyle(fontSize: 11),
//
// labelStyle: TextStyle(fontSize: 11),
// border: InputBorder.none
// ),
// ))
//
// ],
// ),
// )
// ],
// )
