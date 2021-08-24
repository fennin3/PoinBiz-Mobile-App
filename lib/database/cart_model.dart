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

  CartModel(
      {this.quantity,
      this.price,
      this.title,
      this.image,
      this.total,
      this.size,
      this.color,
      this.id,
      this.store_id});
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
      this.fee
      });
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

  WishItem({this.quantity,
    this.price,
    this.title,
    this.image,
    this.total,
    this.size,
    this.color,
    this.prodid,
    this.store_id});
}
