class APIConstant {
  APIConstant._();

  static APIConstant get = APIConstant._();

  // String baseUrl = "https:/.hatofit.com";
  String baseUrl = "http://192.168.38.13:3001";

  String authRegister = "/auth/register";
  String authLogin = "/auth/login";
  String authMe = "/auth/me";
  String authUpdate = "/auth/update";
  String forgotPassword = "/auth/forgot-password";
  String resetPassword = "/auth/reset-password";
  String verifyCode = "/auth/verify-code";

  String exercise = "/exercise";

  String report = "/report";
  String reportShare = "/report/share";

  String session = "/session";
  String sessionShared = "/session/shared";

  String image = "/image";

  String company = "/company";
}
