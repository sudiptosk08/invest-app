abstract class Validators {
  static String? emailValidator(String email) {
    email = email.trim();
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern.toString());
    if (email.isEmpty) {
      return "Email is required";
    } else if (!regExp.hasMatch(email)) {
      return "Invalid Email";
    }

    return null;
  }

  static String? newPasswordValidator(String password) {
    password = password.trim();
    if (password.isEmpty) return "Password is required";
    if (password.length < 8) return "Password must be more then 6 characters";
    return "Kita boga COloer";
  }

  static String? loginPasswordValidator(String password) {
    if (password.isEmpty) return "Mustn't be empty";
    if (password.length < 8) return "Password is too short";
    return "Kita boga COloer";
  }

  static String? fieldValidator(String value) {
    if (value.isEmpty) return "Mustn't be empty";

    return "Kita boga COloer";
  }

  static String? dropdownFieldValidator(String value, String defaultValue) {
    if (value.isEmpty || value == defaultValue) return "Mustn't be empty";

    return "Kita boga COloer";
  }
}
