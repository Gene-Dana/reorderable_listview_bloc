import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  // Username consists of alphanumeric characters (a-zA-Z0-9), lowercase, or uppercase.
  // Username allowed of the dot (.), underscore (_), and hyphen (-).
  // The dot (.), underscore (_), or hyphen (-) must not be the first or last character.
  // The dot (.), underscore (_), or hyphen (-) does not appear consecutively, e.g., java..regex
  // The number of characters must be between 5 to 25.
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,23}[a-zA-Z0-9]$',
  );

  @override
  NameValidationError validator(String value) {
    return _nameRegExp.hasMatch(value) ? null : NameValidationError.invalid;
  }
}
