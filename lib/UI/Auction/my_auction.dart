import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/Auction/auction_detail.dart';
import 'package:treva_shop_flutter/constant.dart';

class MyAuctionSales extends StatefulWidget {
  const MyAuctionSales({Key key}) : super(key: key);

  @override
  _MyAuctionSalesState createState() => _MyAuctionSalesState();
}

class _MyAuctionSalesState extends State<MyAuctionSales> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "My Auction Sales",
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
        child: ListView.builder(
            itemCount: 5,
            padding: EdgeInsets.only(top: 10, bottom: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionDetail())),
                  title: Text("Product name"),
                  subtitle: Text("Quantity: 10"),
                  leading:
                  Hero(
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
                                              child: Image.asset(
                                                "assets/img/man.png",

                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                              )),
                                          Positioned(
                                              right: 10,
                                              top: 10,
                                              child: TextButton(
                                                onPressed: ()=>Navigator.pop(context),
                                                child: Card(child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Icon(Icons.close, color: Colors.black,),
                                                ),),
                                              ))
                                        ],
                                      ),

                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 500)));
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/img/man.png"),
                        ),
                      ),
                    ),
                  ),
                  trailing: Card(
                    elevation: 10,
                    color: appColor,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("10", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}