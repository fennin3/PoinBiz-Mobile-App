import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/DetailProduct.dart';
import 'package:provider/provider.dart';

class ItemGridMain extends StatefulWidget {
  /// Get data from HomeGridItem.....dart class
  Map gridItem;
  final String word;

  ItemGridMain(this.gridItem, this.word);

  @override
  State<ItemGridMain> createState() => _ItemGridMainState();
}

class _ItemGridMainState extends State<ItemGridMain> {
  double rate = 0.0;

  int calRate() {
    if (widget.gridItem['reviews'].length > 0) {
      for (var rev in widget.gridItem['reviews']) {
        setState(() {
          rate += double.parse(rev['rating'].toString());
        });
      }
    }

    if (rate > 0) {
      setState(() {
        rate = rate / widget.gridItem['reviews'].length;
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
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return InkWell(
      onTap: () {
        if (widget.word.isNotEmpty) {
          _pro.saveWord(widget.word);
        }
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new detailProduk(widget.gridItem),
            transitionDuration: Duration(milliseconds: 900),

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
                  tag: "hero-grid-${widget.gridItem['id']}",
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
                                        tag:
                                            "hero-grid-${widget.gridItem['id']}",
                                        child: Image.network(
                                          widget.gridItem['image']['path'],
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
                      child: Stack(
                        children: [
                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    topRight: Radius.circular(7.0)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.gridItem['image']['path']),
                                    fit: BoxFit.cover)),
                          ),
                          if (int.parse(
                                  widget.gridItem['discount'].toString()) >
                              0)
                            Positioned(
                                right: 0,
                                child: Card(
                                  color: Colors.teal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      widget.gridItem['discount_type'] ==
                                              'amount'
                                          ? "GHc ${widget.gridItem['discount']} OFF"
                                          : "${widget.gridItem['discount']}% OFF",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
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
                    widget.gridItem['name'].toString().length > 18 ? widget.gridItem['name'].toString().substring(0, 19) + "...": widget.gridItem['name'],
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
                if(int.parse(widget.gridItem['discount'].toString()) > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      "GHc " + widget.gridItem['price'].toString(),
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
                      "GHc " + widget.gridItem['price'].toString(),
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),

                    ),
                  ),
                if(int.parse(widget.gridItem['discount'].toString()) > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      "GHc " + widget.gridItem['discount_price'].toString(),
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
                            "$rate",
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black38,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        "564",
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
