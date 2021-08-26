import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/ListItem/HomeGridItemRecomended.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/CategoryDetail.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/DetailProduct.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/FlashSale.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/PromotionDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class Menu extends StatefulWidget {
  final scaKey;

  Menu({this.scaKey});

  @override
  _MenuState createState() => _MenuState();
}

/// Component all widget in home
class _MenuState extends State<Menu> with TickerProviderStateMixin {
  /// Declare class GridItem from HomeGridItemReoomended.dart in folder ListItem
  ///
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GridItem gridItem;


  /// CountDown for timer

  void _getInitData() {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);

    _pro.getallCategories();
    _pro.getBanners();
    _pro.getPromos();
    _pro.getProducts();
    _pro.getAddresses();
    _pro.getCartItem();
    _pro.getEventCategories();
    _pro.getAllEvent();
    _pro.getAllBuses();
    _pro.getDestinations();
    _pro.getCartData();
    _pro.getWishListData();
    _pro.getConfig();
    _pro.getOrders();
    _pro.getUserDetail();
    _pro.getPlacedOrders();
    _pro.getAllBusinessTypes();
    _pro.getAuction();
    _pro.getRegions();
  }

  @override
  void initState() {
    _getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    _pro.getProducts();
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    /// Navigation to promoDetail.dart if user Click icon in Week Promotion
    var onClickWeekPromotion = () {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new promoDetail(
                title: "Weekly Promotion",
              ),
          transitionDuration: Duration(milliseconds: 750),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    };

    /// Navigation to categoryDetail.dart if user Click icon in Category
    onClickCategory(Map data) {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new categoryDetail(
                data: data,
              ),
          transitionDuration: Duration(milliseconds: 450),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    }

    /// Declare device Size
    var deviceSize = MediaQuery.of(context).size;

    /// ImageSlider in header
    var imageSlider = _pro.allbanners.isNotEmpty
        ? Container(
            height: 182.0,
            width: double.infinity,
            child: new Carousel(
              boxFit: BoxFit.cover,
              dotColor: Color(0xFF6991C7).withOpacity(0.8),
              dotSize: 5.5,
              dotSpacing: 16.0,
              dotBgColor: Colors.transparent,
              showIndicator: true,
              overlayShadow: true,
              overlayShadowColors: Colors.white.withOpacity(0.9),
              overlayShadowSize: 0.9,
              images: [
                for (var banner in _pro.allbanners)
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (banner['caption_one'].length > 1)
                          Text(
                            "${banner['caption_one']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        SizedBox(
                          height: 3,
                        ),
                        if (banner['caption_two'].length > 1)
                          Text(
                            "${banner['caption_two']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                      ],
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${banner['image']['path']}"))),
                    height: 182,
                  ),
                // AssetImage("assets/img/baner12.png"),
                // AssetImage("assets/img/baner2.png"),
                // AssetImage("assets/img/baner3.png"),
                // AssetImage("assets/img/baner4.png"),
              ],
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey.withOpacity(0.5),
            child: Container(
              height: 182.0,
              width: double.infinity,
              color: Colors.black,
            ),
          );

    /// CategoryIcon Component
    var categoryIcon = Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.0),
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0.0),
            child: Text(
              "Menu",
              style: TextStyle(
                  fontSize: 13.5,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          _pro.allcategories != null
              ? GridView.extent(
                  // childAspectRatio: (2 / 2),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,

                  maxCrossAxisExtent: 100.0,
                  children: [
                    for (var cat in _pro.allcategories)
                      InkWell(
                        onTap: () => onClickCategory(cat),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              cat['icon']['path'],
                              height: 30,
                            ),
                            Padding(padding: EdgeInsets.only(top: 7.0)),
                            Text(
                              cat['name'],
                              style: TextStyle(
                                fontFamily: "Sans",
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                  shrinkWrap: true,
                )
              : GridView.extent(
                  // childAspectRatio: (2 / 2),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  padding: EdgeInsets.all(10.0),
                  maxCrossAxisExtent: 100.0,
                  children: List.generate(12, (index) {
                    return Column(
                      children: <Widget>[
                        CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                        Padding(padding: EdgeInsets.only(top: 7.0)),
                        Text(
                          "Category name",
                          style: TextStyle(
                            fontFamily: "Sans",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    );
                  }),
                  shrinkWrap: true,
                ),
        ],
      ),
    );

    /// ListView a WeekPromotion Component
    var PromoHorizontalList = _pro.allpromos.length > 0
        ? Container(
            color: Colors.white,
            height: 230.0,
            padding: EdgeInsets.only(bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 15.0, bottom: 3.0),
                    child: Text(
                      "Promotions",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w700),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _pro.allpromos.length,
                      padding: EdgeInsets.only(top: 10.0 ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: onClickWeekPromotion,
                            child: Stack(
                              children: [
                                Image.network(
                                    _pro.allpromos[index]['image']['path']),
                                Positioned(
                                    right: 0,
                                    child: Container(
                                      color: appColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: _pro.allpromos[index]['product']
                                                    ['discount_type'] ==
                                                "amount"
                                            ? Text(
                                                "GHc ${_pro.allpromos[index]['product']['discount']} OFF",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(
                color: appColor,
                backgroundColor: Colors.white,
              ),
            ),
          );

    /// FlashSale component
    var FlashSell = Container(
      height: 390.0,
      decoration: BoxDecoration(
        /// To set Gradient in flashSale background
        gradient: LinearGradient(colors: [
          Color(0xFF7F7FD5).withOpacity(0.8),
          Color(0xFF86A8E7),
          Color(0xFF91EAE4)
        ]),
      ),

      /// To set FlashSale Scrolling horizontal
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: mediaQueryData.padding.left + 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/img/flashsaleicon.png",
                    height: deviceSize.height * 0.087,
                  ),
                  Text(
                    "Flash",
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Sale",
                    style: TextStyle(
                      fontFamily: "Sans",
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: mediaQueryData.padding.top + 30),
                  ),
                ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 40.0)),

          /// Get a component flashSaleItem class
          for (var item in _pro.allpromos)
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: flashSaleItem(
                  id: item['id'].toString(),
                  image: item['image']['path'],
                  title: item['product']['name'],
                  normalprice: "Ghc ${item['product']['price']}",
                  discountprice: "GHc ${item['product']['discount_price']}",
                  // reviews: item['product']['reviews'],
                  place: "Ghana",
                  stock: item['product']['stock'].toString(),
                  colorLine: 0xFFFFA500,
                  widthLine: double.infinity,
                  duration: item['duration']),
            ),
        ],
      ),
    );

    /// Category Component in bottom of flash sale
    var categoryImageBottom = _pro.allcategories != null
        ? Container(
            height: 210,
            child: GridView.extent(
              scrollDirection: Axis.horizontal,
              childAspectRatio: (2 / 3),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              maxCrossAxisExtent: 105.0,
              children: [
                for (var cat in _pro.allcategories)
                  InkWell(
                    onTap: () => onClickCategory(cat),
                    child: CategoryItemValue(
                      image: cat['image'].toString() == 'false'
                          ? cat['icon']['path']
                          : cat['image']['path'],
                      title: cat['name'],
                    ),
                  ),
              ],
              shrinkWrap: true,
            ),
          )
        : Container(
            height: 210,
            child: GridView.extent(
              scrollDirection: Axis.horizontal,
              childAspectRatio: (2 / 3),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              maxCrossAxisExtent: 105.0,
              children: [
                for (var cat in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
                  Container(
                    child: Center(
                      child: Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                          )),
                    ),
                    color: Colors.grey.withOpacity(0.3),
                  )
              ],
              shrinkWrap: true,
            ),
          );

    ///  Grid item in bottom of Category
    var Grid = Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              "Recommended",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
          ),

          /// To set GridView item
          GridView.extent(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.65,
              // crossAxisCount: 2,
              primary: false,
              
              maxCrossAxisExtent: 300,
              children: List.generate(
                _pro.allProducts.length,
                    (index) => ItemGrid(_pro.allProducts[index]),
              ))
        ],
      ),
    );

    return Scaffold(
      /// Use Stack to costume a appbar
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: mediaQueryData.padding.top + 35.5)),

                  imageSlider,
                  //
                  categoryIcon,

                  if (_pro.allpromos.length > 0) FlashSell,
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  categoryImageBottom,
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  ),
                  //
                  // /// Call a Grid variable, this is item list in Recomended item
                  Grid,
                ],
              ),
            ),

            /// Get a class AppbarGradient
            /// This is a Appbar in home activity
            AppbarGradient(
              scaKey: widget.scaKey,
            ),
          ],
        ),
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatefulWidget {
  /// Get data from HomeGridItem.....dart class
  Map _data;

  ItemGrid(this._data);

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  double rate = 0;

  int calRate() {
    if (widget._data['reviews'].length > 0) {
      for (var rev in widget._data['reviews']) {
        setState(() {
          rate += double.parse(rev['rating'].toString());
        });
      }
    }

    if (rate > 0) {
      setState(() {
        rate = rate / widget._data['reviews'].length;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calRate();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new detailProduk(widget._data),
            transitionDuration: Duration(milliseconds: 400),

            /// Set animation Opacity in route to detailProduk layout
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
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
                /// Set Animation image to detailProduk layout
                Hero(
                  tag: "hero-grid-${widget._data['id']}",
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
                                  child: InkWell(
                                    child: Hero(
                                        tag: "hero-grid-${widget._data['id']}",
                                        child: Image.network(
                                          widget._data['image']['path'],
                                          width: 300.0,
                                          height: 300.0,
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                        )),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500)));
                      },
                      child:

                      Stack(
                        children: [
                          Container(
                            height: 180,
                            width: 200.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    topRight: Radius.circular(7.0)),
                                image: DecorationImage(
                                    image:
                                    NetworkImage(widget._data['image']['path']),
                                    fit: BoxFit.cover)),
                          ),
                          if(int.parse(widget._data['discount'].toString()) > 0)
                          Positioned(
                              right: 0,
                              child: Card(
                                color: Colors.teal,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(widget._data['discount_type'] == 'amount' ? "GHc ${widget._data['discount']} OFF": "${widget._data['discount']}% OFF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    widget._data['name'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                if(int.parse(widget._data['discount'].toString()) > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "GHc " + widget._data['price'].toString(),
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14.0),

                  ),
                )
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      "GHc " + widget._data['price'].toString(),
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),

                    ),
                  ),
                if(int.parse(widget._data['discount'].toString()) > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "GHc " + widget._data['discount_price'].toString(),
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),

                ///Reviews
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "$rate",
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black38,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontFamily: "Sans",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Component FlashSaleItem
class flashSaleItem extends StatefulWidget {
  final String id;
  final String image;
  final String title;
  final String normalprice;
  final String discountprice;
  final List reviews;
  final String place;
  final String stock;
  final int colorLine;
  final double widthLine;
  final int duration;

  flashSaleItem(
      {this.id,
      this.image,
      this.title,
      this.normalprice,
      this.discountprice,
      this.reviews,
      this.place,
      this.stock,
      this.colorLine,
      this.widthLine,
      this.duration});

  @override
  State<flashSaleItem> createState() => _flashSaleItemState();
}

class _flashSaleItemState extends State<flashSaleItem> {
  double rate = 0;

  int calRate() {
    if (widget.reviews!= null && widget.reviews.length > 0) {
      for (var rev in widget.reviews) {
        setState(() {
          rate += double.parse(rev['rating'].toString());
        });
      }
    }else{
      setState(() {
        rate = 0;
      });
    }

    if (rate > 0) {
      setState(() {
        rate = rate / widget.reviews.length;
      });
    }
  }

  void getProd(context) async {
    EasyLoading.show(status: "Loading");
    http.Response response = await http
        .get(Uri.parse(base_url + "general/get-product/${widget.id}"));
    if (response.statusCode < 205) {
      EasyLoading.dismiss();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  detailProduk(json.decode(response.body)['data'])));
    } else {
      EasyLoading.dismiss();
      EasyLoading.showInfo("No internet connection");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calRate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                getProd(context);
              },
              child: Container(
                width: 145.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 140.0,
                      width: 145.0,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                      child: Text(widget.title,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(widget.normalprice,
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(widget.discountprice,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF7F7FD5),
                              fontWeight: FontWeight.w800,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          StarRating(
                            size: 18.0,
                            starCount: 5,
                            rating: rate,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$rate",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        widget.stock + " Available",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Sans",
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: Container(
                        height: 5.0,
                        width: widget.widthLine,
                        decoration: BoxDecoration(
                            color: Color(widget.colorLine),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            shape: BoxShape.rectangle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "Sale ends in :",
                        style: TextStyle(
                          fontFamily: "Sans",
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                    ),

                    /// Get a countDown variable
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: Text(
                        "D" + ": " + "H" + " : " + "M " + ": " + "S",
                        style: TextStyle(
                          fontFamily: "Sans",
                          fontSize: 12.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: CountdownTimer(
                        endTime: widget.duration * 1000,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          if (time == null) {
                            return Text('Sale Ended');
                          }
                          return Text(
                              '${time.days ?? 0} : ${time.hours ?? 0} :  ${time.min ?? 0} : ${time.sec ?? 0}');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

/// Component category item bellow FlashSale
class CategoryItemValue extends StatelessWidget {
  String image, title;

  CategoryItemValue({
    this.image,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 105.0,
      // width: 160.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: Colors.black.withOpacity(0.25),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Berlin",
            fontSize: 18.5,
            letterSpacing: 0.7,
            fontWeight: FontWeight.w800,
          ),
        )),
      ),
    );
  }
}

/// Component item Menu icon bellow a ImageSlider
class CategoryIconValue extends StatelessWidget {
  String icon1, icon2, icon3, icon4, title1, title2, title3, title4;
  GestureTapCallback tap1, tap2, tap3, tap4;

  CategoryIconValue(
      {this.icon1,
      this.tap1,
      this.icon2,
      this.tap2,
      this.icon3,
      this.tap3,
      this.icon4,
      this.tap4,
      this.title1,
      this.title2,
      this.title3,
      this.title4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: tap1,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon1,
                height: 19.2,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title1,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap2,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon2,
                height: 26.2,
              ),
              Padding(padding: EdgeInsets.only(top: 0.0)),
              Text(
                title2,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap3,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon3,
                height: 22.2,
              ),
              Padding(padding: EdgeInsets.only(top: 4.0)),
              Text(
                title3,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap4,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon4,
                height: 19.2,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title4,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

//Stack(
//             children: [
//               Image.asset("assets/img/baner1.png"),
//               Positioned.fill(
//                   child: Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Caption One",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     Text(
//                       "Caption One",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ],
//                 ),
//               )),
//             ],
//           ),
