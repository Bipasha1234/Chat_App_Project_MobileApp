class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String updateProfile = "auth/update-profile-app";
  static const String uploadImage = "auth/uploadImage";
  static const String getCurrentUser = "auth/get-user";

//-----chat routes-----//
  static const String getUsersForSidebar = "messages/users";
  static const String sendMessage = "messages/send/:id";
}
