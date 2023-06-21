import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Screens/Cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/repo/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<FetchProductDetailEvent>(
        (event, emit) => fetchProductDetailEvent(event, emit));
  }

  fetchProductDetailEvent(
      FetchProductDetailEvent event, Emitter<ProductDetailState> emit) {
    final product = ProductRepository.getProductById(id: event.productId);
    emit(ProductDetailLoaded(product));
  }

 
}
    // @override
    // Stream<ProductDetailState> mapEventToState(
    //     ProductDetailEvent event) async* {
    //   if (event is FetchProductDetailEvent) {
    //     yield* _mapFetchProductDetailEventToState(event);
    //   }
    // }

    // Stream<ProductDetailState> _mapFetchProductDetailEventToState(
    //     FetchProductDetailEvent event) async* {
    //   // Fetch product detail from repository using the provided productId
    //   final product = ProductRepository.getProductById(id: event.productId);

    //   // Emit ProductDetailLoaded state with the fetched product
    //   yield ProductDetailLoaded(product);
    // }