part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchProductDetailEvent extends ProductDetailEvent {
  final String productId;

  FetchProductDetailEvent(this.productId);
}
