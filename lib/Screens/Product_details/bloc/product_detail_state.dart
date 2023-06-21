part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  ProductDetailLoaded(this.product);
  
  @override
  List<Object> get props => [product];
}

class ProductDetailError extends ProductDetailState {
   final String errorMessage;

  ProductDetailError(this.errorMessage);
}

