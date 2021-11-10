extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'.{8,20}$'); // match any character including special character
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidOtp {
    final otpRegExp = RegExp(r"^[0-9]{6}$"); //assume 6 digits otp
    return otpRegExp.hasMatch(this);
  }
}
