import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc() : super(SurveyInitial()) {
    on<GetHomeData>(_getHomeData);
  }

  void _getHomeData(GetHomeData event, Emitter<SurveyState> emit) {
    try {
      emit(SurveyLoading());
      final Map<String, dynamic> params = {};
      //API Calling Data
      // final apiResult = await Call API
      //handle response if response is success

      emit(SurveySuccess(combinedValues: event.combinedValues));

      //if getting error false
      // emit(const HomeFailure("Error happened while handling repose"));
    } catch (e) {
      emit(SurveyFailure(e.toString()));
    }
  }
}
