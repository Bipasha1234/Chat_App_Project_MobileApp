import 'package:cool_app/app/constants/api_endpoints.dart';
import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/features/chat/data/data_source/chat_data_source.dart';
import 'package:cool_app/features/chat/data/model/chat_api_model.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRemoteDataSource implements IChatDataSource {
  final Dio dio;

  ChatRemoteDataSource({required this.dio});

  @override
//   Future<List<ChatEntity>> getUsersForSidebar() async {
//     try {
//       final response = await dio.get(ApiEndpoints.getUsersForSidebar);

//       if (response.statusCode == 200) {
//         List<dynamic> usersJson = response.data;
//         List<ChatEntity> users = usersJson.map((json) {
//           ChatApiModel apiModel = ChatApiModel.fromJson(json);
//           return ChatEntity(
//             userId: apiModel.id ?? "",
//             fullname: json["fullname"] ?? "Unknown",
//             profilePic: json["profilePic"] ?? "",
//             latestMessage: json["latestMessage"] ?? "No message",
//             messageTimestamp: json["messageTimestamp"] ?? "",
//           );
//         }).toList();
//         return users;
//       } else {
//         throw Exception("Failed to load users");
//       }
//     } catch (e) {
//       throw Exception("Error fetching users: $e");
//     }
//   }
// }

  @override
  Future<List<ChatEntity>> getUsersForSidebar() async {
    try {
      // Get SharedPreferences instance
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final tokenSharedPrefs = TokenSharedPrefs(prefs);

      // Fetch the token using getToken()
      final tokenResult = await tokenSharedPrefs.getToken();

      // Extract token or handle failure
      String token = tokenResult.fold(
        (failure) =>
            throw Exception("Failed to retrieve token: ${failure.message}"),
        (retrievedToken) => retrievedToken,
      );

      if (token.isEmpty) {
        throw Exception("No token found");
      }

      // Make API request with token in headers
      final response = await dio.get(
        ApiEndpoints.getUsersForSidebar,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> usersJson = response.data;
        List<ChatEntity> users = usersJson.map((json) {
          ChatApiModel apiModel = ChatApiModel.fromJson(json);
          return ChatEntity(
            userId: apiModel.id ?? "",
            fullname: json["fullname"] ?? "Unknown",
            profilePic: json["profilePic"] ?? "",
            latestMessage: json["latestMessage"] ?? "No message",
            messageTimestamp: json["messageTimestamp"] ?? "",
          );
        }).toList();
        return users;
      } else {
        throw Exception("Failed to load users: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }
}
