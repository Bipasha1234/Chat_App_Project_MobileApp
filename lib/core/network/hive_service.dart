import 'package:cool_app/app/constants/hive_table_constant.dart';
import 'package:cool_app/features/auth/data/model/auth_hive_model.dart';
import 'package:cool_app/features/chat/data/model/chat_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}chat_app.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ChatHiveModelAdapter());
  }

  // Save a chat message to Hive
  Future<void> saveChatMessage(ChatHiveModel chatHiveModel) async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);
    await box.put(chatHiveModel.userId, chatHiveModel);
  }

  Future<List<ChatHiveModel>> getChatMessages(String userId) async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);
    return box.values.where((chat) => chat.userId == userId).toList();
  }

  Future<List<ChatHiveModel>> getChatUsers() async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);
    return box.values.toList();
  }

  // Delete a specific chat by userId
  Future<void> deleteChat(String userId) async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);
    await box.delete(userId); // Deleting using userId
  }

  Future<void> blockUser(String userId) async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);

    var chat = box.get(userId);

    if (chat != null) {
      chat.isBlocked = true;

      await box.put(userId, chat);
    }
  }

  Future<void> unblockUser(String userId) async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);

    var chat = box.get(userId);

    if (chat != null) {
      chat.isBlocked = false;
      await box.put(userId, chat);
    }
  }

  // Get blocked users
  Future<List<ChatHiveModel>> getBlockedUsers() async {
    var box = await Hive.openBox<ChatHiveModel>(HiveTableConstant.chatBox);
    return box.values.where((chat) => chat.isBlocked).toList();
  }

  // Clear all chat data
  Future<void> clearAllChats() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.chatBox);
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using email and password
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear user Box
  Future<void> clearuserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
