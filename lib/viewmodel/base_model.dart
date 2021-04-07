import 'package:flutter/cupertino.dart';
import '../model/product.dart';
import '../model/mobile.dart';

class BaseModel extends ChangeNotifier {
  // Product _currentProduct;

  // Product get currentProduct => currentProduct;

  // set currentProduct(Product product) {
  //   _currentProduct = product;
  //   //notifyListeners();
  // }

  List<Product> _products = [];

  List<Product> get products => _products;

  List<Product> fetchProducts() {
    return products;
  }

  updateProduct({
    int index,
    String id,
    String name,
    String description,
    double price,
    int count,
    String type,
    String color,
    int ram,
    List<String> images,
    int storage,
    String processor,
  }) {
    Product product;
    if (type == 'Mobile') {
      product = Mobile(
        id: id,
        name: name,
        description: description,
        price: price,
        count: count,
        type: type,
        color: color,
        ram: ram,
        storage: storage,
        processor: processor,
        images: images,
      );
    }
    Map<String, dynamic> map = product.toJson();
    print(map);
    _products.insert(index, product);
    _products.removeAt(index + 1);
  }

  addProduct({
    String id,
    String name,
    String description,
    double price,
    int count,
    String type,
    String color,
    List<String> images,
    int ram,
    int storage,
    String processor,
  }) {
    Product product;
    if (type == 'Mobile') {
      product = Mobile(
        id: id,
        name: name,
        description: description,
        price: price,
        count: count,
        type: type,
        color: color,
        images: images,
        ram: ram,
        storage: storage,
        processor: processor,
      );
    }
    Map<String, dynamic> map = product.toJson();
    print(map);
    _products.add(product);
    //print(images);
    notifyListeners();
  }
}
