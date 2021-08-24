import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';

class AuctionDetail extends StatefulWidget {
  final Map data;

  AuctionDetail({this.data});

  @override
  _AuctionDetailState createState() => _AuctionDetailState();
}

class _AuctionDetailState extends State<AuctionDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appColor,
      //   centerTitle: true,
      //   title: Text(
      //     "Product Name",
      //     style: auctionHeader,
      //   ),
      //   leading: TextButton(
      //       onPressed: () => Navigator.pop(context),
      //       child: Icon(
      //         Icons.arrow_back,
      //         color: Colors.white,
      //       )),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                floating: true,
                expandedHeight: 200.0,
                backgroundColor: appColor,
                leading: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.data['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  collapseMode: CollapseMode.none,
                  background: Container(
                    width: double.infinity,
                    color: appColor,
                    child: widget.data['image'] != false &&
                            widget.data['image'].isNotEmpty
                        ? Image.network(
                            widget.data['image']['path'],
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/img/point.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sell,
                          color: Colors.white,
                          size: 35,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "GHc ${widget.data['current_bid']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                  // IconButton(
                  //   icon: const Icon(Icons.add_circle),
                  //   tooltip: 'Add new entry',
                  //   onPressed: () { /* ... */ },
                  // ),
                ]),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: SizedBox(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text('${widget.data['description']}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Quantity',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text('${widget.data['quantity']}'),
                  ],
                )),
              ),
            ),
            widget.data['responses'] != null &&
                    widget.data['responses'].length > 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                            color: index.isOdd ? Colors.white : Colors.black12,
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Merchant name: ${widget.data['responses'][index]['merchant']['name']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Unit price offer: GHc ${widget.data['responses'][index]['unit_amount']}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                if (widget.data['responses'][index]
                                            ['unit_amount']
                                        .toString() ==
                                    widget.data['current_bid'].toString())
                                  Tooltip(
                                      message: "Current leading merchant",
                                      child: Image.asset(
                                        "assets/img/medal.png",
                                        width: 35,
                                        height: 35,
                                      ))
                              ],
                            ));
                      },
                      childCount: widget.data['responses'].length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                            color: index.isOdd ? Colors.white : Colors.black12,
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                "No Response yet",
                                style: TextStyle(fontSize: 18),
                              ),
                            ));
                      },
                      childCount: 1,
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            widget.data['status'] == 'active' ? Colors.lightGreen : Colors.grey,
        child: Text(
          widget.data['status'] == 'active' ? "Open" : "Closed",
        ),
      ),
    );
  }
}
