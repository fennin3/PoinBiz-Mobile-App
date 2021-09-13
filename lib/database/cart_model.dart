import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String price;

  @HiveField(2)
  String quantity;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String id;

  @HiveField(5)
  final String color;

  @HiveField(6)
  final String size;

  @HiveField(7)
  String total;

  @HiveField(8)
  final String store_id;

  @HiveField(9)
  final String url;

  @HiveField(10)
  final String shipping_type;

  @HiveField(11)
  final String shipping_cost;

  @HiveField(12)
  final String current_stock;

  @HiveField(13)
  final String type;



  CartModel(
      {this.quantity,
      this.price,
      this.title,
      this.image,
      this.total,
      this.size,
      this.color,
      this.id,
      this.store_id,
      this.url,
      this.current_stock,
      this.shipping_cost,
      this.shipping_type,
      this.type
      });
}

@HiveType(typeId: 0)
class SearchedWord {
  @HiveField(0)
  final String text;

  SearchedWord({this.text});
}

@HiveType(typeId: 2)
class Address {
  @HiveField(0)
  String region;

  @HiveField(1)
  String address;

  @HiveField(2)
  String city;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String recipient;

  @HiveField(5)
  bool defaultt;

  @HiveField(6)
  String fee;

  @HiveField(7)
  String recipient_number;

  Address(
      {this.region,
      this.address,
      this.city,
      this.phone,
      this.recipient,
      this.recipient_number,
      this.defaultt,
      this.fee});
}

@HiveType(typeId: 3)
class WishItem {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String price;

  @HiveField(2)
  String quantity;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String prodid;

  @HiveField(5)
  final String color;

  @HiveField(6)
  final String size;

  @HiveField(7)
  String total;

  @HiveField(8)
  final String store_id;

  @HiveField(9)
  final String url;


  @HiveField(10)
  final String current_stock;


  @HiveField(11)
  final String shipping_cost;

  @HiveField(12)
  final String shipping_type;

  @HiveField(13)
  final String type;

  WishItem(
      {this.quantity,
      this.price,
      this.title,
      this.image,
      this.total,
      this.size,
      this.color,
      this.prodid,
      this.store_id,
      this.url,
      this.current_stock,
      this.shipping_cost,
      this.shipping_type,
      this.type
      });
}

//{this.quantity,
//       this.price,
//       this.title,
//       this.image,
//       this.total,
//       this.size,
//       this.color,
//       this.id,
//       this.store_id,
//       this.url,
//       this.current_stock,
//       this.shipping_cost,
//       this.shipping_type,
//       this.type
//       }
