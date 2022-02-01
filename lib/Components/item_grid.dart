import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/DetailProduct.dart';

import 'my_progress_indicator.dart';


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
                                        child:
                                        // Image.network(widget._data['image']['path'], width: 300.0,
                                        //   height: 300.0,alignment: Alignment.center,filterQuality: FilterQuality.low,)
                                        CachedNetworkImage(
                                          filterQuality: FilterQuality.low,
                                          imageUrl: widget._data['image']['path'],
                                          width: 300.0,
                                          height: 300.0,
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,placeholder: (context, url) => Center(child: MyProgressIndicator()),
                                          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),)

                                    ),
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
                              // image: DecorationImage(image: NetworkImage(widget._data['image']['path']), fit: BoxFit.cover,)
                            ),
                            child: CachedNetworkImage(
                              filterQuality: FilterQuality.low,
                              imageUrl: widget._data['image']['path'],
                              width: 300.0,
                              height: 300.0,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,placeholder: (context, url) => Center(child: MyProgressIndicator()),
                              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),),
                          ),
                          if (widget._data['discount'] > 0)
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
                    widget._data['name'].toString().length > 18 ? widget._data['name'].toString().substring(0,19) + "...": widget._data['name'],
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
                if(widget._data['discount'] > 0)
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
                if(widget._data['discount'] > 0)
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