//import 'package:meta/meta.dart';
//import 'package:products/model/mobile.dart';

class Product {
  final String id;
  final String name;
  final String type;
  final String description;
  final double price;
  final String color;
  final int count;
  final List<String> images;

  Product({
    this.id,
    this.name,
    this.type,
    this.description,
    this.price,
    this.color,
    this.count,
    this.images,
  });

  // factory Product(
  //     {final String id,
  //     final String name,
  //     @required final String type,
  //     final String description,
  //     final double price,
  //     final String color,
  //     final int count,
  //     final List<String> images}) {
  //   if (type == 'mobile') {
  //     return Mobile(
  //       id: id,
  //       name: name,
  //       type: type,
  //       description: description,
  //       price: price,
  //       color: color,
  //       count: count,
  //       images: images,
  //     );
  //   } else {
  //     return null;
  //   }
  // }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      description: map['description'],
      price: map['price'],
      color: map['color'],
      count: map['count'],
      images: map['images'],
    );
  }

  Map<String, dynamic> toJson() => _toJson(this);

  Map<String, dynamic> _toJson(Product product) {
    Map<String, dynamic> map = Map();
    map['id'] = product.id;
    map['name'] = product.name;
    map['type'] = product.type;
    map['description'] = product.description;
    map['price'] = product.price;
    map['color'] = product.color;
    map['count'] = product.count;
    map['images'] = product.images;
    return map;
  }
}
