import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';


class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(appColor),
      strokeWidth: 1.5,
    );
  }
}
