part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

abstract class DashboardActionState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardDataLoadedSuccessState extends DashboardState {
   final List<Product> products;

  DashboardDataLoadedSuccessState(this.products);
}

class DashboardErrorState extends DashboardState {
    final String errorMessage;

  DashboardErrorState(this.errorMessage);
}

class DashboardNavigateToCartActionState extends DashboardActionState {}

class DashboardNavigateToProductTileActionState extends DashboardActionState {}
