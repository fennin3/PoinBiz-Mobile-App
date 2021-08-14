import 'package:hive/hive.dart';

part 'cart_model.g.dart';


@HiveType(typeId: 0)
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