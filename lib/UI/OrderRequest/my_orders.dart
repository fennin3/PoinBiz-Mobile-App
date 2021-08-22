import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/OrderRequest/add_order.dart';
import 'package:treva_shop_flutter/constant.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "My order requests",
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
                    // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionDetail())),
                    title: Text("Product name"),
                    subtitle: Text("Quantity: 10"),
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
                                              child: Image.asset(
                                                "assets/img/man.png",
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
                            backgroundImage: AssetImage("assets/img/man.png"),
                          ),
                        ),
                      ),
                    ),
                    trailing: index % 2 == 0
                        ? Tooltip(
                            message: "Pending response",
                            child: Icon(Icons.pending_actions))
                        : Tooltip(
                            message: "Product Found...",
                            child: Icon(
                              Icons.done_all_sharp,
                              color: Colors.green,
                            ))),
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
