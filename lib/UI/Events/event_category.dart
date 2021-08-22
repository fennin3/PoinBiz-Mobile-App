import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/Events/event_detail.dart';
import 'package:treva_shop_flutter/constant.dart';

class EventCategory extends StatefulWidget {
  final List data;

  EventCategory({this.data});

  @override
  _EventCategoryState createState() => _EventCategoryState();
}

class _EventCategoryState extends State<EventCategory> {
  bool _searchOn = false;

  List _events = [];


  setEvents(){
    setState(() {
      _events = widget.data;
    });
  }


  void toggleSearchOn(){
    setState(() {
      _searchOn = !_searchOn;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: !_searchOn
            ? Text(
                "Category Name",
                style: auctionHeader,
              )
            : TextField(
          style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Search events...",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
              ),
        leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          !_searchOn ? InkWell(
            onTap: ()=>toggleSearchOn(),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ): InkWell(
            onTap: ()=>toggleSearchOn(),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, bottom: 20),
              child: TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventCat(data: _events[index],))),
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
                            child: Image.network(
                              "${_events[index]['image']['path']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: -30,
                              left: 15,
                              child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${_events[index]['date'].toString().split(" at ")[0].split(", ")[1].split(" ")[0]}",
                                          style: TextStyle(
                                              fontFamily: "Sans",
                                              fontSize: 14,
                                              color: appColor,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          "${_events[index]['date'].toString().split(" at ")[0].split(", ")[0]}",
                                          style: TextStyle(
                                              fontFamily: "Sans",
                                              fontSize: 14,
                                              color: appColor,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          "${_events[index]['date'].toString().split(" at ")[0].split(", ")[1].split(" ")[1]}",
                                          style: TextStyle(
                                              fontFamily: "Sans",
                                              fontSize: 14,
                                              color: appColor,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${_events[index]['name']}",
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
                            "${_events[index]['venue']}",
                            style: TextStyle(
                              fontFamily: "Sans",
                              fontSize: 13,
                            ),
                          )),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_events[index]['date'].toString().split(" at ")[1]}",
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
                                  fontWeight: FontWeight.bold),
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
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.1))),
                ),
              ),
            );
          }),
    );
  }
}
