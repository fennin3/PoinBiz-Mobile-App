class CartItem{
  final String title;
  final String price;
  final String image;
  String quantity;


  CartItem({
    this.title,
    this.image,
    this.price,
    this.quantity
});

}


class Region {
  String status;
  String message;
  List<Data> data;

  Region({this.status, this.message, this.data});

  Region.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      List<Data> dat = [];
      json['data'].forEach((v) {
        dat.add(new Data.fromJson(v));
      });
      this.data = dat;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  List<Cities> cities;
  String status;
  String created;
  String updated;

  Data(
      {this.id,
        this.name,
        this.cities,
        this.status,
        this.created,
        this.updated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['cities'] != null) {
      List<Cities> _ci = [];
      json['cities'].forEach((v) {
        _ci.add(new Cities.fromJson(v));
      });

      this.cities = _ci;
    }
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}

class Cities {
  int id;
  String name;
  String fee;
  String status;
  String created;
  String updated;

  Cities(
      {this.id, this.name, this.fee, this.status, this.created, this.updated});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fee = json['fee'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fee'] = this.fee;
    data['status'] = this.status;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}