import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treva_shop_flutter/Library/carousel_pro/src/carousel_pro.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Search.dart';

class VendorDetail extends StatefulWidget {
  const VendorDetail({Key key}) : super(key: key);

  @override
  _VendorDetailState createState() => _VendorDetailState();
}

class _VendorDetailState extends State<VendorDetail> {
  var loadImage = true;

  void offLoadImage(){
    Future.delayed(Duration(seconds: 3)).then((value){
      setState(() {
        loadImage=false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offLoadImage();
  }



  @override
  Widget build(BuildContext context) {
    var _imageSlider = loadImage ? Container(
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
                    height: 180.0,
                    width: double.infinity,
                    color: Colors.black12,
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    ):
    Padding(
      padding: const EdgeInsets.only(
          top: 0.0, bottom: 35.0),
      child: Container(
        height: 190.0,
        child:  Carousel(
          boxFit: BoxFit.cover,
          dotColor: Colors.transparent,
          dotSize: 5.5,
          dotSpacing: 16.0,
          dotBgColor: Colors.transparent,
          showIndicator: false,
          overlayShadow: false,
          overlayShadowColors: Colors.white.withOpacity(0.9),
          overlayShadowSize: 0.9,
          images: [
            AssetImage("assets/img/bannerMan1.png"),
            AssetImage("assets/img/bannerMan2.png"),
            AssetImage("assets/img/bannerMan3.png"),
            AssetImage("assets/img/bannerMan4.png"),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed:(){
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new searchAppbar()));
            },
            icon: Icon(Icons.search, color: Color(0xFF6991C7)),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Vendor Name",
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
      body: _imageSlider,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
      ),
    );
  }
}
