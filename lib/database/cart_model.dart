import 'package:hive/hive.dart';

part 'cart_model.g.dart';


@HiveType(typeId: 1)
class CartModel{
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String price;

  @HiveField(2)
  String quantity;

  @HiveField(3)
  final String image;


  CartModel({this.quantity, this.price, this.title, this.image});


}


@HiveType(typeId: 0)
class SearchedWord{
  @HiveField(0)
  final String text;

  SearchedWord({this.text});

}


@HiveType(typeId: 2)
class Address{
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



  Address({this.name, this.address, this.postal, this.phone, this.recipient,this.defaultt});

}