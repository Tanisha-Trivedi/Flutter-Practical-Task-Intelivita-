part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeData extends HomeEvent {
  final String controllerValue, selectedDate, gridSelectedIndex;
  // multiSelectionValues;
  const GetHomeData({
    required this.controllerValue,
    required this.selectedDate,
    required this.gridSelectedIndex,
    // required this.multiSelectionValues,
  });
}
