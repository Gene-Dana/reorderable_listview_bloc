import 'package:formz/formz.dart';

enum LevelValidationError { invalid }

class DiffLevel extends FormzInput<String, LevelValidationError> {
  const DiffLevel.pure() : super.pure('');
  const DiffLevel.dirty([String value = '']) : super.dirty(value);

  @override
  LevelValidationError validator(String value) {
    return value.length > 0 && value.length < 50
        ? null
        : LevelValidationError.invalid;
  }
}
