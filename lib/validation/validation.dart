import 'package:sms/validation/patterns.dart';
import 'package:sms/validation/regex.dart';

class validation {
  /// Email Validation
  static String? emailValidator(String? value) {
    String? error = 'Email is not valid';

    if (value!.isEmpty) {
      error = "Email can\'t be empty";
    }

    if (SMSregex.hasMatch(value.trim(), SMSPattern.email)) {
      error = null;
    }

    // The pattern of the email didn't match the regex in SMSregex.
    return error;
  }

  /// Email Validation
  static String? passwordValidator(String? value) {
    String? error = 'Password is not valid';

    if (value!.isEmpty) {
      error = "Password can\'t be empty";
    }

    if (SMSregex.hasMatch(value.trim(), SMSPattern.passwordHard)) {
      error = null;
    }

    // The pattern of the email didn't match the regex in SMSregex.
    return error;
  }
}
