import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/ListItem/PromotionData.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treva_shop_flutter/UI/Vendor/vender_detail.dart';


class AllVendors extends StatefulWidget {
  const AllVendors({Key key}) : super(key: key);

  @override
  _AllVendorsState createState() => _AllVendorsState();
}

class _AllVendorsState extends State<AllVendors> {
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



  Widget _imageLoading(BuildContext context){
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 0.67,
      crossAxisCount: 2,
      primary: false,
      children:List.generate(
        /// Get data in PromotionDetail.dart (ListItem folder)
        promotionItem.length,
            (index) => loadingMenuItemCard(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
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
                  hintText: "Search Vendors",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 14.0)),
            ),
          ),
        ));

    var _grid = imageLoad? _imageLoading(context):
    GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 0.67,
      crossAxisCount: 2,
      primary: false,
      children:List.generate(
        /// Get data in flashSaleItem.dart (ListItem folder)
        promotionItem.length,
            (index) => ItemGrid1(promotionItem[index]),
      ),
    );


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Vendors",
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
      body: Column(
        children: [
          _search,
          Expanded(child: _grid)
        ],
      ),
    );
  }
}


class ItemGrid1 extends StatelessWidget {
  @override
  promotionData item;
  ItemGrid1(this.item);
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorDetail())),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 2.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: mediaQueryData.size.height / 3.3,
                  width: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(item.image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class loadingMenuItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              ///
              ///
              /// Shimmer class for animation loading
              ///
              ///
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 205.0,
                        width: 185.0,
                        color: Colors.black12,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5.0,top: 12.0),
                          child: Container(
                            height: 9.5,
                            width: 130.0,
                            color: Colors.black12,
                          )
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
