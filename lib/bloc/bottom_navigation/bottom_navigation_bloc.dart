import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(HomeState());

  // BottomNavigationBloc() : super(BottomNavigationInitial()) {
  // on<BottomNavigationEvent>((event, emit) {});
  // }

  Stream<BottomNavigationState> mapEventToState(
    BottomNavigationEvent event,
  ) async* {
    if (event is LoadHome) {
      yield HomeState();
    }
    if (event is LoadFavorite) {
      yield FavoriteState();
    }
  }
}
