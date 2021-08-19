import 'package:flutter/material.dart';

class FavWidget extends StatefulWidget {
  const FavWidget({
    Key key,
  }) : super(key: key);

  @override
  State<FavWidget> createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  bool fav = false;

  void toggleFav() {
    setState(() {
      fav = !fav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => toggleFav(),
        child: Icon(
          fav ? Icons.favorite_border : Icons.favorite,
          size: 30,
          color: Colors.red,
        ));
  }
}