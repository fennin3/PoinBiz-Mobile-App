// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 1;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      quantity: fields[2] as String,
      price: fields[1] as String,
      title: fields[0] as String,
      image: fields[3] as String,
      total: fields[7] as String,
      size: fields[6] as String,
      color: fields[5] as String,
      id: fields[4] as String,
      store_id: fields[8] as String,
      url: fields[9] as String,
      current_stock: fields[12] as String,
      shipping_cost: fields[11] as String,
      shipping_type: fields[10] as String,
      type: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.size)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.store_id)
      ..writeByte(9)
      ..write(obj.url)
      ..writeByte(10)
      ..write(obj.shipping_type)
      ..writeByte(11)
      ..write(obj.shipping_cost)
      ..writeByte(12)
      ..write(obj.current_stock)
      ..writeByte(13)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SearchedWordAdapter extends TypeAdapter<SearchedWord> {
  @override
  final int typeId = 0;

  @override
  SearchedWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchedWord(
      text: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchedWord obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchedWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 2;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      region: fields[0] as String,
      address: fields[1] as String,
      city: fields[2] as String,
      phone: fields[3] as String,
      recipient: fields[4] as String,
      recipient_number: fields[7] as String,
      defaultt: fields[5] as bool,
      fee: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.region)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.recipient)
      ..writeByte(5)
      ..write(obj.defaultt)
      ..writeByte(6)
      ..write(obj.fee)
      ..writeByte(7)
      ..write(obj.recipient_number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WishItemAdapter extends TypeAdapter<WishItem> {
  @override
  final int typeId = 3;

  @override
  WishItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishItem(
      quantity: fields[2] as String,
      price: fields[1] as String,
      title: fields[0] as String,
      image: fields[3] as String,
      total: fields[7] as String,
      size: fields[6] as String,
      color: fields[5] as String,
      prodid: fields[4] as String,
      store_id: fields[8] as String,
      url: fields[9] as String,
      current_stock: fields[10] as String,
      shipping_cost: fields[11] as String,
      shipping_type: fields[12] as String,
      type: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishItem obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.prodid)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.size)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.store_id)
      ..writeByte(9)
      ..write(obj.url)
      ..writeByte(10)
      ..write(obj.current_stock)
      ..writeByte(11)
      ..write(obj.shipping_cost)
      ..writeByte(12)
      ..write(obj.shipping_type)
      ..writeByte(13)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
