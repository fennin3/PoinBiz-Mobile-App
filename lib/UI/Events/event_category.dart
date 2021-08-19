import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/Events/event_detail.dart';
import 'package:treva_shop_flutter/constant.dart';

class EventCategory extends StatefulWidget {
  const EventCategory({Key key}) : super(key: key);

  @override
  _EventCategoryState createState() => _EventCategoryState();
}

class _EventCategoryState extends State<EventCategory> {
  bool _searchOn = false;


  void toggleSearchOn(){
    setState(() {
      _searchOn = !_searchOn;
    });
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
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventCat())),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "04",
                                          style: TextStyle(
                                              fontFamily: "Sans",
                                              fontSize: 10,
                                              color: appColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "August",
                                          style: TextStyle(
                                              fontFamily: "Sans",
                                              fontSize: 10,
                                              color: appColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )))
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
                                fontSize: 12,
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
                              fontSize: 11,
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
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "From Ghc 30",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  fontSize: 13,
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
                      border: Border.all(color: Colors.black.withOpacity(0.1))),
                ),
              ),
            );
          }),
    );
  }
}
