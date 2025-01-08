import 'package:cool_app/bloc/chat_event.dart';
import 'package:cool_app/bloc/chat_state.dart';
import 'package:cool_app/model/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  // Simulating a data source (could be an API, database, etc.)
  final List<Chat> _chatList = [
    Chat(
        name: "Ram Krishna Lamsal",
        message: "Thanks a bunch! Have a great day! 😊",
        time: "10:25",
        unreadCount: 3),
    Chat(
        name: "Hari Karki",
        message: "Great, thanks so much! 👋",
        time: "22:20 05/05"),
    Chat(
        name: "Angela Kelly",
        message: "Appreciate it! See you soon! 🚀",
        time: "10:45 08/05"),
    Chat(name: "Bipasha Lamsal", message: "Hooray! 🎉", time: "20:10 05/05"),
    Chat(name: "Sita Karki", message: "See you soon!", time: "11:20 05/05"),
  ];

  ChatBloc() : super(ChatInitialState());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is FetchChatsEvent) {
      yield ChatLoadingState();
      try {
        // Simulate data fetch (replace with real API/database logic)
        await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
        yield ChatLoadedState(chats: _chatList);
      } catch (e) {
        yield ChatErrorState(errorMessage: e.toString());
      }
    } else if (event is AddChatEvent) {
      _chatList.add(event.chat);
      yield ChatLoadedState(chats: _chatList);
    } else if (event is RemoveChatEvent) {
      _chatList.removeWhere((chat) => chat.name == event.chatName);
      yield ChatLoadedState(chats: _chatList);
    }
  }
}
