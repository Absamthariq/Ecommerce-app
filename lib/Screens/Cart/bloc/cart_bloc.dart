import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Screens/Cart/widgets/checkout.dart';
import 'package:ecommerce_app/model/cart_model/cart.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/repo/cart_repo.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartLoadingState()) {
    on<AddToCartEvent>((event, emit) => addToCartEvent(event, emit));
    on<FetchCartEvent>((event, emit) => _mapFetchCartEventToState(event, emit));
    on<IncreaseQuantityEvent>(
        (event, emit) => _mapIncreaseQuantityEventToState(event, emit));
    on<DecreaseQuantityEvent>(
        (event, emit) => _mapDecreaseQuantityEventToState(event, emit));
    on<ClearCartEvent>((event, emit) => clearCartEvent(event, emit));
    on<DeleteProductEvent>((event, emit) => deleteProductEvent(event, emit));
  }

  void addToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      cartRepository.addToCart(
        product: event.product,
        id: event.productId,
      );
      print('Product added');

      emit(ProductAddedToCart(event.product, event.productId));
      //  emit(ShowSnackbarEvent(message: 'mesdssdsage'));
    } catch (error) {
      emit(AddProductToCartError(error.toString()));
    }
  }

  Future<void> _mapFetchCartEventToState(
      FetchCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      final List<Cart> cartItems = await cartRepository.getCartItems();
      final double totalPrice = await cartRepository.calculateTotalPrice();
      emit(CartLoadedState(cartItems, totalPrice));
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
  }

  Future<void> _mapIncreaseQuantityEventToState(
      IncreaseQuantityEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoadedState) {
      try {
        final updatedCartItems = List<Cart>.from(currentState.cartItems);

        final cartItemIndex =
            updatedCartItems.indexWhere((item) => item.id == event.cartItemId);
        if (cartItemIndex != -1) {
          final cartItem = updatedCartItems[cartItemIndex];
          cartItem.quantity++;

          final double totalPrice = await cartRepository.calculateTotalPrice();
          emit(CartLoadedState(updatedCartItems, totalPrice));
        } else {
          emit(currentState); // No changes if cart item not found
        }
      } catch (error) {
        emit(CartErrorState(error.toString()));
      }
    }
  }

  Future<void> _mapDecreaseQuantityEventToState(
      DecreaseQuantityEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoadedState) {
      try {
        final updatedCartItems = List<Cart>.from(currentState.cartItems);

        final cartItemIndex =
            updatedCartItems.indexWhere((item) => item.id == event.cartItemId);
        if (cartItemIndex != -1) {
          final cartItem = updatedCartItems[cartItemIndex];
          if (cartItem.quantity > 1) {
            cartItem.quantity--;

            final double totalPrice =
                await cartRepository.calculateTotalPrice();
            emit(CartLoadedState(updatedCartItems, totalPrice));
          } else {
            // Remove cart item if quantity becomes zero
            await cartRepository
                .removeItem(cartItem.id); // Use the removeItem method

            final updatedCartItems = await cartRepository
                .getCartItems(); // Retrieve updated cart items
            final double totalPrice =
                await cartRepository.calculateTotalPrice();
            emit(CartLoadedState(updatedCartItems, totalPrice));
          }
        } else {
          emit(currentState); // No changes if cart item not found
        }
      } catch (error) {
        emit(CartErrorState(error.toString()));
      }
    }
  }

  clearCartEvent(ClearCartEvent event, Emitter<CartState> emit) async {
    try {
      await cartRepository.clearCart();
      emit(CartEmptyState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
  }

  deleteProductEvent(DeleteProductEvent event, Emitter<CartState> emit) async {
    try {
      await cartRepository.deleteProductById(event.productId);
      // cartRepository.updateCartItem();
      // emit(ProductDeletedState());
         final updatedCartItems = await cartRepository
                .getCartItems(); //
      final double totalPrice = await cartRepository.calculateTotalPrice();
      emit(CartLoadedState(updatedCartItems, totalPrice));
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
  }

  // deleteProductEvent(DeleteProductEvent event, Emitter<CartState> emit)async {
  //  try {
  //   await cartRepository.deleteProductById(event.productId);
  //   emit(ProductDeletedState());
  // } catch (error) {
  //   emit(CartErrorState(error.toString()));
  // }
  // }
}
