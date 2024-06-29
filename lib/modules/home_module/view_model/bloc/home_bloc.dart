import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetHomeData>(_getHomeData);
  }

  void _getHomeData(GetHomeData event, Emitter<HomeState> emit) {
    try {
      emit(HomeLoading());
      final Map<String, dynamic> params = {};
      //API Calling Data
      // final apiResult = await Call API
      //handle response if response is success

      emit(HomeSuccess(
          gridSelectedIndex: event.gridSelectedIndex,
          selectedDate: event.selectedDate,
          controllerValue: event.controllerValue));

      //if getting error false
      // emit(const HomeFailure("Error happened while handling repose"));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
