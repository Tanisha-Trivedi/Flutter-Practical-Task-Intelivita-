import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle_task/modules/home_module/view/home_screen.dart';
import 'package:flutter_practicle_task/modules/home_module/view_model/bloc/survey_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practical',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => SurveyBloc(),
        child: SurveyPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
