part of 'survey_bloc.dart';

sealed class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object> get props => [];
}

final class SurveyInitial extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveySuccess extends SurveyState {
  final List<dynamic> combinedValues;

  const SurveySuccess({
    required this.combinedValues,
  });
}

class SurveyFailure extends SurveyState {
  final String errorMessage;

  const SurveyFailure(this.errorMessage);
}
