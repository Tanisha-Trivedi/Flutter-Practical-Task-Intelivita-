part of 'survey_bloc.dart';

sealed class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => [];
}

class GetHomeData extends SurveyEvent {
  final List<dynamic> combinedValues;
  const GetHomeData({
    required this.combinedValues,
  });
}
