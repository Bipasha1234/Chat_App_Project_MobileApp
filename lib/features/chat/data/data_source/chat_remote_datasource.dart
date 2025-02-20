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
  Future<List<ChatEntity>> getUsersForSidebar() async {
    try {
      // Get SharedPreferences instance
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final tokenSharedPrefs = TokenSharedPrefs(prefs);

      // Fetch the token using getToken()
      final tokenResult = await tokenSharedPrefs.getToken();

      // Extract token or handle failure
      String token = tokenResult.fold(
        (failure) {
          print(
              "Failed to retrieve token: ${failure.message}"); // Log the error
          throw Exception("Failed to retrieve token: ${failure.message}");
        },
        (retrievedToken) {
          print("Token retrieved: $retrievedToken"); // Log the token
          return retrievedToken;
        },
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

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        List<dynamic> usersJson = response.data ?? [];
        List<ChatEntity> users = usersJson.map((json) {
          // Safe handling of the response fields
          String userId =
              json["_id"] ?? ''; // Fallback to an empty string if null
          String fullName = json["fullName"] ?? "Unknown";
          String profilePic = json["profilePic"] ?? "";
          String email = json["email"] ?? "";

          String latestMessage = json["latestMessage"] ?? "No message";
          DateTime? lastMessageTime = json['lastMessageTime'] != null
              ? DateTime.tryParse(json['lastMessageTime'])
              : null;

          String senderId = json["senderId"] ?? '';
          String receiverId = json["receiverId"] ?? '';

          // Create and return ChatEntity
          return ChatEntity(
            userId: userId,
            senderId: senderId,
            receiverId: receiverId,
            fullName: fullName,
            profilePic: profilePic,
            email: email,
            latestMessage: latestMessage,
            lastMessageTime: lastMessageTime,
          );
        }).toList();

        return users;
      } else {
        print("Error: Response status code is not 200.");
        throw Exception("Failed to load users: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      // Log DioException details to investigate further
      print("DioException occurred: ${e.message}");
      print("DioException details: ${e.response?.data}");
      print("DioException type: ${e.type}");
      print("DioException requestOptions: ${e.requestOptions}");

      // Check if there is a response and print it
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }

      // Re-throw the exception for further handling
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      print("Error: $e");
      throw Exception("Error fetching users: $e");
    }
  }

  @override
  Future<bool> sendMessage(ChatEntity chatEntity) async {
    try {
      // Get SharedPreferences instance for the token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final tokenSharedPrefs = TokenSharedPrefs(prefs);

      // Fetch the token using getToken()
      final tokenResult = await tokenSharedPrefs.getToken();

      // Extract token or handle failure
      String token = tokenResult.fold(
        (failure) {
          print(
              "Failed to retrieve token: ${failure.message}"); // Log the error
          throw Exception("Failed to retrieve token: ${failure.message}");
        },
        (retrievedToken) {
          print("Token retrieved: $retrievedToken"); // Log the token
          return retrievedToken;
        },
      );

      // Ensure token is not empty
      if (token.isEmpty) {
        throw Exception("No token found");
      }

      // Convert entity to model
      var chatApiModel = ChatApiModel.fromEntity(chatEntity);

      // Make the API call to send the message
      var response = await dio.post(
        ApiEndpoints.sendMessage,
        data: chatApiModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }, // Set Authorization header with Bearer token
        ),
      );

      // Log the response status and data
      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      // Check if the message was sent successfully (201 Created)
      if (response.statusCode == 201) {
        return true; // Message sent successfully
      } else {
        print("Error: Response status code is not 201.");
        throw Exception("Failed to send message: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      // Log DioException details for investigation
      print("DioException occurred: ${e.message}");
      print("DioException details: ${e.response?.data}");
      print("DioException type: ${e.type}");
      print("DioException requestOptions: ${e.requestOptions}");

      // Check if there is a response and print it
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }

      // Re-throw the exception for further handling
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      // Log other types of errors
      print("Error: $e");
      throw Exception("Error sending message: $e");
    }
  }

  @override
  Future<List<ChatEntity>> getMessages(String chatId, String? token) async {
    try {
      var response = await dio.get(
        ApiEndpoints.getMessages + chatId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> messagesJson = response.data ?? [];
        List<ChatEntity> messages = messagesJson.map((json) {
          // Safe handling of the response fields
          String userId = json["_id"] ?? '';
          String text = json["text"] ?? "No text";
          String email = json["email"] ?? "No email";
          String image = json["image"] ?? "No image";
          String fullName = json["text"] ?? "Unknown";
          String profilePic = json["profilePic"] ?? "";
          String latestMessage = json["latestMessage"] ?? "No message";
          DateTime? lastMessageTime = json['lastMessageTime'] != null
              ? DateTime.tryParse(json['lastMessageTime'])
              : null;
          DateTime? createdAt = json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null;

          String senderId = json["senderId"] ?? '';
          String receiverId = json["receiverId"] ?? '';

          // Create and return ChatEntity
          return ChatEntity(
              userId: userId,
              senderId: senderId,
              receiverId: receiverId,
              text: text,
              email: email,
              image: image,
              fullName: fullName,
              profilePic: profilePic,
              latestMessage: latestMessage,
              lastMessageTime: lastMessageTime,
              createdAt: createdAt);
        }).toList();

        return messages;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteChat(String chatId, String? token) async {
    try {
      var response = await dio.delete(
        ApiEndpoints.deleteChat + chatId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> blockUser(String chatId, String? token) async {
    try {
      var response = await dio.post(
        ApiEndpoints.blockUser + chatId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> unblockUser(String chatId, String? token) async {
    try {
      var response = await dio.post(
        ApiEndpoints.unblockUser + chatId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ChatEntity>> getBlockedUsers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final tokenSharedPrefs = TokenSharedPrefs(prefs);

      final tokenResult = await tokenSharedPrefs.getToken();

      String token = tokenResult.fold(
        (failure) {
          print("Failed to retrieve token: ${failure.message}");
          throw Exception("Failed to retrieve token: ${failure.message}");
        },
        (retrievedToken) {
          print("Token retrieved: $retrievedToken");
          return retrievedToken;
        },
      );

      if (token.isEmpty) {
        throw Exception("No token found");
      }

      final response = await dio.get(
        ApiEndpoints.getBlockedUsers,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        // Check if response.data is a map and access the blockedUsers list
        if (response.data is Map<String, dynamic>) {
          // Extract the blockedUsers list from the map
          List<dynamic> blockedUsersJson = response.data['blockedUsers'] ?? [];

          // Map the decoded data into ChatEntity list
          List<ChatEntity> blockedUsers = blockedUsersJson.map((json) {
            String userId = json["_id"] ?? '';
            String fullName = json["fullName"] ?? "Unknown";
            String profilePic = json["profilePic"] ?? "";
            String email = json["email"] ?? "";

            String latestMessage = json["latestMessage"] ?? "No message";
            DateTime? lastMessageTime = json['lastMessageTime'] != null
                ? DateTime.tryParse(json['lastMessageTime'])
                : null;

            String senderId = json["senderId"] ?? '';
            String receiverId = json["receiverId"] ?? '';

            return ChatEntity(
              userId: userId,
              senderId: senderId,
              receiverId: receiverId,
              fullName: fullName,
              profilePic: profilePic,
              email: email,
              latestMessage: latestMessage,
              lastMessageTime: lastMessageTime,
            );
          }).toList();

          return blockedUsers;
        } else {
          print(
              "Error: Expected a Map in the response data, but got ${response.data.runtimeType}");
          throw Exception("Expected a Map in the response data.");
        }
      } else {
        print("Error: Response status code is not 200.");
        throw Exception(
            "Failed to load blocked users: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("DioException occurred: ${e.message}");
      print("DioException details: ${e.response?.data}");
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      print("Error: $e");
      throw Exception("Error fetching blocked users: $e");
    }
  }
}
