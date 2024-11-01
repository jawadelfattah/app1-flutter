class Validator {
  static bool isValidEmail(String email) {
    // Regular expression for email validation
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression for phone number validation
    final RegExp regex = RegExp(r'^[0]{1}[0-9]{9}$'); // Assuming 10 digits for simplicity
    return regex.hasMatch(phoneNumber);
  }
  static bool isValidPassword(String passwword) {
    // Regular expression for phone number validation
    final RegExp regex =RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(passwword);
  }
}