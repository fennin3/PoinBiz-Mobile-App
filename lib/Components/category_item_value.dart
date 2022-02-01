import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'my_progress_indicator.dart';

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
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: Colors.black.withOpacity(0.25),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child:
              // Image.network(image, filterQuality: FilterQuality.low, fit: BoxFit.cover,)
              CachedNetworkImage(
                filterQuality: FilterQuality.low,
                imageUrl: "$image", fit: BoxFit.cover, placeholder: (context, url) => Center(child: MyProgressIndicator()),
                errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),),
            ),
            Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Berlin",
                    fontSize: 18.5,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w800,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
