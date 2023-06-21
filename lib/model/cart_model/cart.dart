import 'package:hive/hive.dart';

import '../product.dart';
part 'cart.g.dart';
@HiveType(typeId: 1)
class Cart extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Product product;

  @HiveField(2)
  int quantity;

  Cart({
    required this.id,
    required this.product,
    required this.quantity,
  });


  Cart copyWith({
    String? id,
    Product? product,
    int? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}



