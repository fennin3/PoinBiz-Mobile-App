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
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  String postal;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String recipient;

  @HiveField(5)
  bool defaultt;

  Address(
      {this.name,
      this.address,
      this.postal,
      this.phone,
      this.recipient,
      this.defaultt});
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
