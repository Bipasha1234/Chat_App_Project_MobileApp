class RegisterModel {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  // Validation methods
  String? validateEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
    if (email.isEmpty) {
      return "Email cannot be empty";
    } else if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword() {
    if (password.isEmpty) {
      return "Password cannot be empty";
    } else if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword() {
    if (confirmPassword.isEmpty) {
      return "Confirm Password cannot be empty";
    } else if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
