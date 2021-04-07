import './product.dart';

class Mobile extends Product {
  final int ram;
  final int storage;
  final String processor;

  Mobile({
    String id,
    String name,
    String description,
    double price,
    int count,
    List<String> images,
    String type,
    String color,
    this.ram,
    this.storage,
    this.processor,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          count: count,
          images: images,
          color: color,
          type: type,
        );

  Mobile copyWith({
    String id,
    String name,
    String description,
    double price,
    int count,
    List<String> images,
    String type,
    String color,
    int ram,
    int storage,
    String processor,
  }) {
    return Mobile(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      count: count ?? this.count,
      color: color ?? this.color,
      images: images ?? this.images,
      processor: processor ?? this.processor,
      ram: ram ?? this.ram,
      storage: storage ?? this.storage,
      type: type ?? this.type,
    );
  }
}
