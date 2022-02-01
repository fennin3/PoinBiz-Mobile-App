import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treva_shop_flutter/Components/loading_items.dart';
import 'package:treva_shop_flutter/Components/product_item.dart';
import 'package:treva_shop_flutter/ListItem/HomeGridItemRecomended.dart';
import 'package:treva_shop_flutter/ListItem/PromotionData.dart';

class promoDetail extends StatefulWidget {
  final String title;
  final String id;


  promoDetail({@required this.title, this.id});

  @override
  _promoDetailState createState() => _promoDetailState();
}



class _promoDetailState extends State<promoDetail> {


  // var imageNetwork = NetworkImage("https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213931.png?alt=media&token=e6287f67-5bc0-4225-8e96-1623dc9dc42f");




  bool imageLoad = true;



  @override
  void initState() {
     Timer(Duration(seconds: 3),(){
      setState(() {
        imageLoad=false;
      });
     });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    /// Item Search in bottom of appbar
    var _search = Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Theme(
            data: ThemeData(hintColor: Colors.transparent),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black38,
                    size: 18.0,
                  ),
                  hintText: "Search Items",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 14.0)),
            ),
          ),
        ));

    /// Grid Item a product
    var _grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///
            ///
            /// check the condition if image data from server firebase loaded or no
            /// if image true (image still downloading from server)
            /// Card to set card loading animation
            ///
            ///
            imageLoad? _imageLoading(context):
                Container()
            // GridView.count(
            //   shrinkWrap: true,
            //   padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
            //   crossAxisSpacing: 10.0,
            //   mainAxisSpacing: 15.0,
            //   childAspectRatio: 0.6,
            //   crossAxisCount: 2,
            //   primary: false,
            //   children:List.generate(
            //     /// Get data in flashSaleItem.dart (ListItem folder)
            //     promotionItem.length,
            //         (index) => ItemGridMain(gridItemArray[index]),
            //   ),
            // )
          ],
        ),
      ),
    );

    return Scaffold(
      /// Appbar item
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF6991C7),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            /// Calling search and grid variable
            children: <Widget>[
              _search,
              _grid,
            ],
          ),
        ),
      ),
    );
  }
}

///
///
///
/// Loading Item Card Animation Constructor
///
///
///


///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _imageLoading(BuildContext context){
  return GridView.count(
    shrinkWrap: true,
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 15.0,
    childAspectRatio: 0.545,
    crossAxisCount: 2,
    primary: false,
    children:List.generate(
      /// Get data in PromotionDetail.dart (ListItem folder)
      promotionItem.length,
          (index) => loadingMenuItemCard(),
    ),
  );
}