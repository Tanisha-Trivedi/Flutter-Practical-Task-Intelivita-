import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle_task/modules/home_module/view/survey_form.dart';

import '../model/user_model.dart';
import '../view_model/bloc/survey_bloc.dart';

class SurveyPage extends StatelessWidget {
  final List<SurveyField> mockSurveyFields = [
    EditField('Name'),
    DatePickerField('Date of Birth'),
    DropdownField('Select Country', ['USA', 'Canada', 'UK', 'Germany']),
    GridField('Select Interests', ['Sports', 'Music', 'Movies', 'Books']),
    MultiSelectField(
        'Select Hobbies', ['Traveling', 'Gaming', 'Cooking', 'Photography']),
  ];

  SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Page'),
      ),
      body: BlocProvider(
        create: (context) => SurveyBloc(),
        child: SurveyForm(fields: mockSurveyFields),
      ),
    );
  }
}
