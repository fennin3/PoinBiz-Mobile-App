import 'package:flutter/cupertino.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Components/addreview.dart';
import 'package:treva_shop_flutter/Components/fav_widget.dart';
import 'package:treva_shop_flutter/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/ListItem/HomeGridItemRecomended.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/CartLayout.dart';
import 'package:treva_shop_flutter/UI/CartUIComponent/Delivery.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/ReviewLayout.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:treva_shop_flutter/constant.dart';

class detailProduk extends StatefulWidget {
  Map gridItem;

  detailProduk(this.gridItem);

  @override
  _detailProdukState createState() => _detailProdukState(gridItem);
}

/// Detail Product for Recomended Grid in home screen
class _detailProdukState extends State<detailProduk> {
  double rating = 3.5;
  int starCount = 5;

  /// Declaration List item HomeGridItemRe....dart Class
  final Map gridItem;

  _detailProdukState(this.gridItem);

  double rate = 0;

  int calRate() {
    if (widget.gridItem['reviews'].length > 0) {
      for (var rev in widget.gridItem['reviews']) {
        setState(() {
          rate += double.parse(rev['rating']);
        });
      }
    }

    if (rate > 0) {
      setState(() {
        rate = rate / widget.gridItem['reviews'].length;
      });
    }
  }

  void addReview(){

    showModalBottomSheet(
        isScrollControlled: true,

        enableDrag: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
        ),
        context: context, builder: (context){
      return Wrap(
        children: [
          AddReview()
        ],
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calRate();
  }

  @override
  static BuildContext ctx;
  int valueItemChart = 0;
  int _nu = 0;
  int _num = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  /// BottomSheet for view more in specification
  void _bottomSheet(String text) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Center(
                          child: Text(
                        "Description",
                        style: _subHeaderCustomStyle,
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Text("$text", style: _detailText),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      //   child: Text(
                      //     " - Lorem ipsum is simply dummy  ",
                      //     style: _detailText,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// Custom Text black
  static var _customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: "Gotik",
      fontSize: 16.0);

  /// Custom Text for Detail title
  static var _detailText = TextStyle(
      fontFamily: "Gotik",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  /// Variable Component UI use in bottom layout "Top Rated Products"
  var _suggestedItem = Padding(
    padding:
        const EdgeInsets.only(left: 15.0, right: 20.0, top: 30.0, bottom: 20.0),
    child: Container(
      height: 280.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Top Rated Products",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: Colors.indigoAccent.withOpacity(0.8),
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 20.0, bottom: 2.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FavoriteItem(
                  image: "assets/imgItem/shoes1.jpg",
                  title: "Firrona Skirt!",
                  Salary: "\$ 10",
                  Rating: "4.8",
                  sale: "923 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/acesoris1.jpg",
                  title: "Arpenaz 4",
                  Salary: "\$ 200",
                  Rating: "4.2",
                  sale: "892 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/kids1.jpg",
                  title: "Mon Cheri Pingun",
                  Salary: "\$ 3",
                  Rating: "4.8",
                  sale: "110 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/man1.jpg",
                  title: "Polo T Shirt",
                  Salary: "\$ 8",
                  Rating: "4.4",
                  sale: "210 Sale",
                ),
                Padding(padding: EdgeInsets.only(right: 10.0)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => new cart()));
            },
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -0.8),
              children: <Widget>[
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black26,
                    )),
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: Colors.red,
                  child: Text(
                    _pro.cart.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Product Detail",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 17.0,
            fontFamily: "Gotik",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Header image slider
                  Stack(
                    children: [
                      Container(
                        height: 300.0,
                        child: Hero(
                          tag: "hero-grid-${gridItem['id']}",
                          child: Material(
                            child: new Carousel(
                              dotColor: Colors.black26,
                              dotIncreaseSize: 1.7,
                              dotBgColor: Colors.transparent,
                              autoplay: false,
                              boxFit: BoxFit.cover,
                              images: [
                                NetworkImage(gridItem['image']['path']),
                                for (var img in gridItem['gallery'])
                                  NetworkImage(img['path']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(bottom: 10, right: 10, child: FavWidget())
                    ],
                  ),

                  /// Background white title,price and ratting
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            gridItem['name'],
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Text(
                            "GHc " + gridItem['price'].toString(),
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Divider(
                            color: Colors.black12,
                            height: 1.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      width: 75.0,
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "$rate",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0)),
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 19.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    "${widget.gridItem['stock']} Available",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /// Background white for chose Size and Color
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Size", style: _subHeaderCustomStyle),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  for (var size in gridItem['sizes'])
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 20),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                print(gridItem['sizes']
                                                    .indexOf(size));
                                                _nu = gridItem['sizes']
                                                    .indexOf(size);
                                              });
                                            },
                                            child: SizeWidget(
                                              text: "${size['name']}",
                                              index: gridItem['sizes']
                                                  .indexOf(size),
                                              nu: _nu,
                                            ))),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            Divider(
                              color: Colors.black12,
                              height: 1.0,
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0)),
                            Text(
                              "Color",
                              style: _subHeaderCustomStyle,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  for (var color in gridItem['colors'])
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 20),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _num = gridItem['colors']
                                                  .indexOf(color);
                                            });
                                          },
                                          child: ColorWidget(
                                            color: HexColor(color['code']),
                                            index: gridItem['colors']
                                                .indexOf(color),
                                            nu: _num,
                                          )),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 600.0,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Description",
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                  left: 20.0),
                              child: Text(gridItem['description'],
                                  style: _detailText),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  _bottomSheet(gridItem['description']);
                                },
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15.0,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Background white for Ratting
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Reviews',
                                  style: _subHeaderCustomStyle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 15.0, bottom: 15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.0, right: 3.0),
                                            child: Text(
                                              'View All',
                                              style: _subHeaderCustomStyle
                                                  .copyWith(
                                                      color:
                                                          Colors.indigoAccent,
                                                      fontSize: 14.0),
                                            )),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ReviewsAll(
                                                        rating: rate,
                                                        reviews:
                                                            widget.gridItem[
                                                                'reviews'],
                                                      )));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, top: 2.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18.0,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      StarRating(
                                        size: 25.0,
                                        starCount: 5,
                                        rating: rate,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                          '${widget.gridItem['reviews'].length} Reviews')
                                    ]),
                              ],
                            ),
                            if (widget.gridItem['reviews'].length > 4)
                              for (var review
                                  in widget.gridItem['reviews'].sublist(0, 3))
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 20.0,
                                          top: 15.0,
                                          bottom: 7.0),
                                      child: _line(),
                                    ),
                                    _buildRating(
                                        '${review['created']}',
                                        '${review['comment']}',
                                        rate,
                                        "${review['user']['avatar']['path']}"),
                                  ],
                                )
                            else
                              for (var review in widget.gridItem['reviews'])
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 20.0,
                                          top: 15.0,
                                          bottom: 7.0),
                                      child: _line(),
                                    ),
                                    _buildRating(
                                        '${review['created']}',
                                        '${review['comment']}',
                                        rate,
                                        "${review['user']['avatar']['path']}"),
                                  ],
                                ),
                            SizedBox(
                              height: 30,
                            ),
                            ///Add Review Button
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 20.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       InkWell(
                            //         onTap: ()=>addReview(),
                            //         child: Container(
                            //             color: Colors.indigoAccent,
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(10.0),
                            //               child: Text(
                            //                 "Add Review",
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontSize: 16),
                            //               ),
                            //             )),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(padding: EdgeInsets.only(bottom: 30.0)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // _suggestedItem
                ],
              ),
            ),
          ),

          /// If user click icon chart SnackBar show
          /// this code to show a SnackBar
          /// and Increase a valueItemChart + 1
          InkWell(
            onTap: () {
              _pro.addToCart({
                "title": gridItem['name'],
                "image": gridItem['image']['path'],
                "price": gridItem['price'].toString(),
                "quantity": "1"
              }, _key);

            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        height: 40.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            border: Border.all(color: Colors.black12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Add To Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            Image.asset(
                              "assets/icon/shopping-cart.png",
                              height: 23.0,
                            ),
                          ],
                        )),

                    /// Chat Icon
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(PageRouteBuilder(
                    //         pageBuilder: (_, ___, ____) => new chatItem()));
                    //   },
                    //   child: Container(
                    //     height: 40.0,
                    //     width: 60.0,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white12.withOpacity(0.1),
                    //         border: Border.all(color: Colors.black12)),
                    //     child: Center(
                    //       child: Image.asset("assets/icon/message.png",
                    //           height: 20.0),
                    //     ),
                    //   ),
                    // ),

                    /// Button Pay
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new delivery()));
                      },
                      child: Container(
                        height: 45.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                        ),
                        child: Center(
                          child: Text(
                            "Pay",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRating(String date, String details, double rate, String image) {
    return ListTile(
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
      title: Row(
        children: <Widget>[
          StarRating(
            size: 20.0,
            rating: rate,
            starCount: 5,
            color: Colors.yellow,
          ),
          SizedBox(width: 8.0),
          Text(
            date,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      subtitle: Text(
        details,
        style: _detailText,
      ),
    );
  }
}

class SizeWidget extends StatelessWidget {
  final String text;
  final index;
  final nu;

  SizeWidget({this.text, this.index, this.nu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: index != nu ? 37.0 : 50,
      width: index != nu ? 37.0 : 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: index != nu ? Colors.black54 : Colors.indigoAccent),
          shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: index != nu ? Colors.black54 : Colors.indigoAccent),
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final color;
  final index;
  final nu;

  ColorWidget({this.color, this.index, this.nu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: index != nu ? 37.0 : 50,
      width: index != nu ? 37.0 : 50,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
              color: index != nu ? Colors.black54 : Colors.indigoAccent),
          shape: BoxShape.circle),
    );
  }
}

/// Class for card product in "Top Rated Products"
class FavoriteItem extends StatelessWidget {
  String image, Rating, Salary, title, sale;

  FavoriteItem({this.image, this.Rating, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
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
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    Salary,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
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
                            Rating,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        sale,
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

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
