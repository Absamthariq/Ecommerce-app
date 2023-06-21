import 'package:ecommerce_app/model/product.dart';

class Cart {
  String id;
  Product? product;
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
