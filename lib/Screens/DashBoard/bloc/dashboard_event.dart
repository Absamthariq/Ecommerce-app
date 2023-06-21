part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}
class FetchData extends DashboardEvent {}
class DashboardCartButtonClickNavigateEvent extends DashboardEvent{

}
class DashboardProductTileToDetailNavigateEvent extends DashboardEvent{

} 