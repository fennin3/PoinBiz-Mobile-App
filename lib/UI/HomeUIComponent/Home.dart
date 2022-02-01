import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Components/category_icon_widget.dart';
import 'package:treva_shop_flutter/Components/category_image_sec.dart';
import 'package:treva_shop_flutter/Components/category_item_value.dart';
import 'package:treva_shop_flutter/Components/flash_sell.dart';
import 'package:treva_shop_flutter/Components/grid_item.dart';
import 'package:treva_shop_flutter/Components/image_slider_widget.dart';
import 'package:treva_shop_flutter/Components/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/Components/product_item.dart';
import 'package:treva_shop_flutter/ListItem/HomeGridItemRecomended.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/CategoryDetail.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/PromotionDetail.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  bool _loading = false;

  void setLoading() {
    setState(() {
      _loading = true;
    });

    Future.delayed(Duration(seconds: 4)).then((value) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  void _getInitData() {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    _pro.getCartItem();
    _pro.getCartData();
    _pro.getWishListData();
    _pro.getOrders();
    _pro.getUserDetail();
    _pro.getPlacedOrders();
    try {
      _pro.getAddresses();
    } catch (e) {}
    try {
      _pro.getUserDetail();
    } catch (e) {}
  }

  /// CountDown for timer

  @override
  void initState() {
    _getInitData();
    setLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
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

    /// Declare device Size
    var deviceSize = MediaQuery.of(context).size;

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
                      padding: EdgeInsets.only(top: 10.0),
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

    /// Category Component in bottom of flash sale

    ///  Grid item in bottom of Category

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Padding under the nav bar
                  Padding(
                      padding: EdgeInsets.only(
                          top: mediaQueryData.size.height * 0.065)),

                  /// Image Slider
                  ImageSlider(
                    pro: _pro,
                  ),

                  /// Menu Text
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 20.0, bottom: 10),
                    child: Text(
                      "Menu",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  ///Category Icons Grid
                  CategoryIconWidget(
                    pro: _pro,
                    onClickCategory: onClickCategory,
                  ),

                  ///Promotion Section
                  if (_pro.allpromos.length > 0)
                    FlashSell(
                      pro: _pro,
                    ),

                  // Padding(
                  //   padding: EdgeInsets.only(top: 10.0),
                  // ),

                  /// Category Images

                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 20.0, bottom: 10),
                    child: Text(
                      "Categories",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  CategoryImagesWidget(pro: _pro, fun: onClickCategory,),




                  GridBody(pro: _pro,)



                ],
              ),
            ),

            //SingleChildScrollView(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: <Widget>[
            //                   Padding(
            //                       padding: EdgeInsets.only(
            //                           top: mediaQueryData.padding.top + 35.5)),
            //
            //                   ImageSlider(pro: _pro,),
            //                   //
            //                   Padding(padding: EdgeInsets.only(top: 15),
            //                   child: Padding(
            //                     padding: EdgeInsets.only(left: 20.0, top: 0.0),
            //                     child: Text(
            //                       "Menu",
            //                       textAlign: TextAlign.start,
            //                       style: TextStyle(
            //                           fontSize: 13.5,
            //                           fontFamily: "Sans",
            //                           fontWeight: FontWeight.w700),
            //                     ),
            //                   ),
            //                   ),
            //
            //                   CategoryIcons(pro: _pro),
            //
            //                   if (_pro.allpromos.length > 0) FlashSell(pro: _pro,),
            //
            //                   Padding(
            //                     padding: EdgeInsets.only(top: 10.0),
            //                   ),
            //
            //                   CategoryImages(pro: _pro,fun: onClickCategory,),
            //
            //                   Padding(
            //                     padding: EdgeInsets.only(bottom: 10.0),
            //                   ),
            //                   //
            //                   // /// Call a Grid variable, this is item list in Recomended item
            //                   GridBody(pro: _pro),
            //                 ],
            //               ),
            //             ),

            AppbarGradient(
              scaKey: widget.scaKey,
            ),
          ],
        ),
      ),
    );
  }
}

class GridBody extends StatelessWidget {
  final PoinBizProvider pro;

  GridBody({this.pro});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          GridView.builder(
              cacheExtent: 1200,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 4,
                mainAxisExtent: 300,
              childAspectRatio: 0.65,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0
            ),
              // crossAxisCount: 2,
              primary: false,
              itemCount: pro.allProducts.length,
            itemBuilder: (BuildContext context, int index){
                return ItemGridMain(pro.allProducts[index],"");
            },
          ),
        ],
      ),
    );
  }
}
