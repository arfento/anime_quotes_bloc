part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class HomeState extends BottomNavigationState {
  final int index = 0;
  final String title = 'Home';

  @override
  List<Object> get props => [index, title];
}

class FavoriteState extends BottomNavigationState {
  int index = 1;
  String title = 'Favorite';

  @override
  List<Object> get props => [index, title];

  //  FavoriteState({required this.index, required this.title});
}

class BottomNavigationInitial extends BottomNavigationState {}
