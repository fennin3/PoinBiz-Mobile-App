import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';

import 'category_item_value.dart';



class CategoryImagesWidget extends StatelessWidget {
  final PoinBizProvider pro;
  final Function fun;

  CategoryImagesWidget({this.pro, this.fun});

  @override
  Widget build(BuildContext context) {
    return pro.allcategories == null
        ? Container(
      height: 210,
      child: GridView.extent(
        scrollDirection: Axis.horizontal,
        childAspectRatio: (2 / 3),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        maxCrossAxisExtent: 105.0,
        children: [
          for (var cat in [1, 2, 3, 4, 5, 6, 7, 8])
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
    )
        : Container(
      height: 210,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:  2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,
            childAspectRatio: 2/3, mainAxisExtent: 150),
        itemCount: pro.allcategories.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: ()=> fun(pro.allcategories[index]),
            child: CategoryItemValue(
              image: pro.allcategories[index]['image'].toString() == 'false'
                  ? pro.allcategories[index]['icon']['path']
                  : pro.allcategories[index]['image']['path'],
              title: pro.allcategories[index]['name'],
            ),
          );
        },
      ),
    );
  }
}
