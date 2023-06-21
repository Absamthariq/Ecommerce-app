part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}
class CartInitial extends CartState{}
class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Cart> cartItems;
  final double totalPrice;

  CartLoadedState(this.cartItems, this.totalPrice);

  @override
  List<Object> get props => [cartItems, totalPrice];
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);

  @override
  List<Object> get props => [error];
}
class ProductAddedToCart extends CartState {
  final Product product;
  final String productId;

  ProductAddedToCart(this.product, this.productId);
}

class AddProductToCartError extends CartState {
  final String error;

  AddProductToCartError(this.error);
}

// abstract class CartState extends Equatable {
//   const CartState();

//   @override
//   List<Object> get props => [];
// }

// class CartInitial extends CartState {}

// class CartItemsLoading extends CartState {}

// class CartItemsLoaded extends CartState {
//   final List<Cart> cartItems;

//   const CartItemsLoaded(this.cartItems);

//   @override
//   List<Object> get props => [cartItems];
// }

// class CartItemsEmpty extends CartState {}

// class CartItemsError extends CartState {
//   final String errorMessage;

//   const CartItemsError(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }
// class AddProductToCart extends CartState {

// }

// class ProductAddedToCart extends CartState {
//   final Product product;
//   final String productId;

//   const ProductAddedToCart(this.product, this.productId);

//   @override
//   List<Object> get props => [product, productId];
// }

// class AddProductToCartError extends CartState {
//   final String errorMessage;

//   const AddProductToCartError(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }

// class IncreaseQuantityState extends CartState {
//   final List<Cart> cartItems;
//   final double totalPrice;

//   IncreaseQuantityState(this.cartItems, this.totalPrice) : super();
// }
// class IncreaseQuantityError extends CartState{
//   final String errorMessage;

//   IncreaseQuantityError(this.errorMessage);

// }
// class DecreaseQuantityState extends CartState {
//   final List<Cart> cartItems;
//   final double totalPrice;

//   DecreaseQuantityState(this.cartItems, this.totalPrice) : super();
// }
// class DecreseQuantityError extends CartState{
//   final String errorMessage;

//   DecreseQuantityError(this.errorMessage);

// }
// class CartUpdateState extends CartState{
//   final List<Cart> cartiem;

//   CartUpdateState(this.cartiem);
// }