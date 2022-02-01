import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/constant.dart';

import 'my_progress_indicator.dart';

class CategoryIconWidget extends StatelessWidget {
  final PoinBizProvider pro;
  final Function onClickCategory;
  
  CategoryIconWidget({this.pro, this.onClickCategory});

  @override
  Widget build(BuildContext context) {
    return pro.allcategories == null ? GridView.extent(
      // childAspectRatio: (2 / 2),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      padding: EdgeInsets.all(10.0),
      maxCrossAxisExtent: 100.0,
      children: List.generate(6, (index) {
        return Column(
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(appColor),
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
    ):
    Container(
      height: 180,
      alignment: AlignmentDirectional.centerStart,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics (),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1,  mainAxisSpacing: 4, crossAxisSpacing: 4,
        ),
        itemCount: pro.allcategories.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: () => onClickCategory(pro.allcategories[index]),
            child: Column(
              children: <Widget>[
                // Image.network(pro.allcategories[index]['icon']['path'],  fit: BoxFit.cover, filterQuality: FilterQuality.low,),
                CachedNetworkImage(
                  filterQuality: FilterQuality.low,
                  imageUrl: "${pro.allcategories[index]['icon']['path']}", fit: BoxFit.cover, placeholder: (context, url) => Center(child: MyProgressIndicator()),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error),), height: 30,),

                Padding(padding: EdgeInsets.only(top: 7.0)),
                Text(
                  pro.allcategories[index]['name'],
                  style: TextStyle(
                    fontFamily: "Sans",
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
