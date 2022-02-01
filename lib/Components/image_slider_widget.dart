import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Library/carousel_pro/src/carousel_pro.dart';

import 'my_progress_indicator.dart';


class ImageSlider extends StatelessWidget {
  final PoinBizProvider pro;

  ImageSlider({this.pro});

  @override
  Widget build(BuildContext context) {
    return pro.allbanners.isNotEmpty
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
          for (var banner in pro.allbanners)
            Container(
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 182,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(image: NetworkImage(banner['image']['path']),
                      //     fit: BoxFit.cover,),
                      // ),
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.low,
                        imageUrl: "${banner['image']['path']}", fit: BoxFit.cover, placeholder: (context, url) => Center(child: MyProgressIndicator()),
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),)

                  ),
                  Column(
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
                ],
              ),
              width: double.infinity,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage("${banner['image']['path']}"))),
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
  }
}