import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/repo/product_repository.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchData>((event, emit) => _mapFetchDataToState(event, emit));

    on<DashboardCartButtonClickNavigateEvent>(
        dashboardCartButtonClickNavigateEvent);

    on<DashboardProductTileToDetailNavigateEvent>(
        dashboardProductTileToDetailNavigateEvent);
  }

  void _mapFetchDataToState(
      FetchData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    try {
      final List<Product> products = await ProductRepository.getAllProducts();
      emit(DashboardDataLoadedSuccessState(products));
    } catch (error) {
      emit(DashboardErrorState(error.toString()));
    }
  }

  FutureOr<void> dashboardCartButtonClickNavigateEvent(
      DashboardCartButtonClickNavigateEvent event,
      Emitter<DashboardState> emit) {
    print('dashboardToCartNavigateButtonCLicked');
    emit(DashboardNavigateToCartActionState());
  }

  FutureOr<void> dashboardProductTileToDetailNavigateEvent(
      DashboardProductTileToDetailNavigateEvent event,
      Emitter<DashboardState> emit) {
    print('DashboardToProductDetailPageNavigateClicked');
    emit(DashboardNavigateToProductTileActionState());
  }
}
