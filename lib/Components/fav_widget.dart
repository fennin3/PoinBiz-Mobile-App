import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
class FavWidget extends StatefulWidget {
  final WishItem item;

  FavWidget({this.item});

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

  setWished(data){
    for (var a in data){

      if (a.prodid == widget.item.prodid && a.title == widget.item.title){
        setState(() {
           fav = true;
        });
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    setWished(_pro.wishlist);
    return InkWell(
        onTap: (){
          toggleFav();
          if(fav){
            _pro.addWishList(widget.item, 'offline');
          }
          else{
            _pro.removeWishList(widget.item);
          }

        },
        child: Icon(
          !fav ? Icons.favorite_border : Icons.favorite,
          size: 30,
          color: Colors.red,
        ));
  }
}