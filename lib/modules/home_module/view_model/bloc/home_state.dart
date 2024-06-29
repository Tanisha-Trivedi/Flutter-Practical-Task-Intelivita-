part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final String controllerValue, selectedDate, gridSelectedIndex;

  const HomeSuccess({
    required this.controllerValue,
    required this.selectedDate,
    required this.gridSelectedIndex,
  });
}

class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure(this.errorMessage);
}
