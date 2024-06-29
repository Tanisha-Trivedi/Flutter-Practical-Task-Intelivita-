// survey_field.dart
enum SurveyFieldType {
  EditField,
  DatePicker,
  Dropdown,
  Grid,
  MultiSelect,
}

abstract class SurveyField {
  final SurveyFieldType type;
  final String label;

  SurveyField(this.type, this.label);
}

class EditField extends SurveyField {
  EditField(String label) : super(SurveyFieldType.EditField, label);
}

class DatePickerField extends SurveyField {
  DatePickerField(String label) : super(SurveyFieldType.DatePicker, label);
}

class DropdownField extends SurveyField {
  final List<String> options;

  DropdownField(String label, this.options)
      : super(SurveyFieldType.Dropdown, label);
}

class GridField extends SurveyField {
  final List<String> options;

  GridField(String label, this.options) : super(SurveyFieldType.Grid, label);
}

class MultiSelectField extends SurveyField {
  final List<String> options;

  MultiSelectField(String label, this.options)
      : super(SurveyFieldType.MultiSelect, label);
}
