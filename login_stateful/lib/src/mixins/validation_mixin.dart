class ValidationMixin {
  String validateEmail(String email) {
    if (!email.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String validatePassword(String password) {
    if (password.trim().length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}