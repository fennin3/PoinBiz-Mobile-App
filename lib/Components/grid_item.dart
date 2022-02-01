import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'my_progress_indicator.dart';

class ItemGrid extends StatelessWidget {
  @override
  Map item;

  ItemGrid(this.item);
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
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
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0)),
                        // image: DecorationImage(
                        //     image: NetworkImage(item['image']['path']), fit: BoxFit.cover)
                    ),
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.low,
                      imageUrl: "${item['image']['path']}", fit: BoxFit.cover, placeholder: (context, url) => Center(child: MyProgressIndicator()),
                      errorWidget: (context, url, error) => Center(child: Icon(Icons.error),)),
                  ),
                  Container(
                    height: 25.5,
                    width: 55.0,
                    decoration: BoxDecoration(
                        color: Color(0xFFD7124A),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(5.0))),
                    child: Center(
                        child: Text( item['discount_type'] == "percentage"?
                        "${item['discount']}%" : "GHc ${item['discount']}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        )),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  item['name'],
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text("GHc " +
                    item['price'].toString(),
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
                          "rating",
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
                      "Sale",
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
    );
  }
}