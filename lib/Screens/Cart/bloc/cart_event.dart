part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class IncreaseQuantityEvent extends CartEvent {
  final String cartItemId;

  IncreaseQuantityEvent(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class DecreaseQuantityEvent extends CartEvent {
  final String cartItemId;

  DecreaseQuantityEvent(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}
class AddToCartEvent extends CartEvent {
  final Product product;
  final String productId;

  const AddToCartEvent(this.product, this.productId);

  @override
  List<Object> get props => [product, productId];
}
