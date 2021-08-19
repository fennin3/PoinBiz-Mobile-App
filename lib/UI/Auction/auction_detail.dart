import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';

class AuctionDetail extends StatefulWidget {
  const AuctionDetail({Key key}) : super(key: key);

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
                  title: Text('Product name', style: TextStyle(color: Colors.white),),
                  centerTitle: true,
                  collapseMode: CollapseMode.none,
                  background: Container(
                    width: double.infinity,
                    color: Colors.red,
                    child: Image.asset(
                      "assets/img/man.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                actions: <Widget>[
                  // IconButton(
                  //   icon: const Icon(Icons.add_circle),
                  //   tooltip: 'Add new entry',
                  //   onPressed: () { /* ... */ },
                  // ),
                ]),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: SizedBox(

                  child: Center(
                    child: Text('Scroll to see the SliverAppBar in effect. fb vhv hjf v vfgcc dcvgv gvcs gv  g gdv jv d v gd dcvyjvvg gvdcgv'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
