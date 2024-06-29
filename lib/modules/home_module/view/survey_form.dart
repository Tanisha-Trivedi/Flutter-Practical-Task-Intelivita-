import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle_task/modules/home_module/view_model/bloc/survey_bloc.dart';

import '../model/user_model.dart';

class SurveyForm extends StatefulWidget {
  final List<SurveyField> fields;

  const SurveyForm({super.key, required this.fields});

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  late List<String?> fieldValues;

  @override
  void initState() {
    super.initState();
    fieldValues = List.filled(widget.fields.length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SurveyBloc, SurveyState>(
        listener: (context, state) {
          if (state is SurveySuccess) {
            print("Combined Values: ${state.combinedValues}");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Survey submitted successfully')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: widget.fields.length,
                itemBuilder: (_, index) =>
                    _buildFormField(widget.fields[index], index)),
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: _submitForm,
        child: const Text("Save"),
      ),
    );
  }

  Widget _buildFormField(SurveyField field, int index) {
    switch (field.type) {
      case SurveyFieldType.EditField:
        return TextFormField(
          decoration: InputDecoration(labelText: field.label),
          onChanged: (value) => fieldValues[index] = value,
        );
      case SurveyFieldType.DatePicker:
        return Row(
          children: [
            Text(fieldValues[index] ?? ''),
            const Spacer(),
            ElevatedButton(
              child: const Text("select date"),
              onPressed: () async {
                // Implement date picker logic
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    fieldValues[index] = pickedDate.toString();
                  });
                }
              },
            ),
          ],
        );
      case SurveyFieldType.Dropdown:
        DropdownField dropdownField = field as DropdownField;
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: field.label),
          items: dropdownField.options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              fieldValues[index] = value;
            });
          },
        );
      case SurveyFieldType.Grid:
        GridField gridField = field as GridField;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: gridField.options.length,
          itemBuilder: (context, gridIndex) {
            return CheckboxListTile(
              title: Text(gridField.options[gridIndex]),
              value: fieldValues[index] == gridField.options[gridIndex],
              onChanged: (bool? value) {
                setState(() {
                  if (value!) {
                    fieldValues[index] = gridField.options[gridIndex];
                  } else {
                    fieldValues[index] = null;
                  }
                });
              },
            );
          },
        );
      case SurveyFieldType.MultiSelect:
        MultiSelectField multiSelectField = field as MultiSelectField;
        List<String> selectedOptions = [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(field.label),
            for (String option in multiSelectField.options)
              CheckboxListTile(
                title: Text(option),
                value: fieldValues[index] == option,
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }
                    fieldValues[index] = selectedOptions.isNotEmpty
                        ? selectedOptions.toString()
                        : null;
                  });
                },
              ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _submitForm() {
    for (String? value in fieldValues) {
      if (value == null || value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')),
        );
        return;
      }
    }
    List<dynamic> combinedValues = List.from(fieldValues);
    context.read<SurveyBloc>().add(GetHomeData(combinedValues: combinedValues));
  }
}
