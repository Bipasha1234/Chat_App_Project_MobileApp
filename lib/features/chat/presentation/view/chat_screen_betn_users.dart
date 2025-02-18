import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/presentation/view_model/login/chat_bloc.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart'; // For decoding JWT
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For formatting the date

class ChatScreen extends StatefulWidget {
  final ChatEntity user;

  const ChatScreen({super.key, required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late ChatBloc _chatBloc;
  String? _senderId; // This will hold the senderId

  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>();
    _getSenderId(); // Fetch senderId (token) from SharedPreferences
  }

  // Fetch the senderId from SharedPreferences (or token)
  Future<void> _getSenderId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final tokenSharedPrefs = TokenSharedPrefs(sharedPreferences);

    final result = await tokenSharedPrefs.getToken();
    result.fold(
      (failure) {
        // Handle error (e.g., log, show message)
        print('Error fetching token: ${failure.message}');
      },
      (token) {
        setState(() {
          try {
            // Decoding the JWT token
            final jwt = JWT.decode(token); // Decode the token
            final payload = jwt.payload;

            // Assuming the field you're looking for is named 'userId' or something similar
            _senderId = payload[
                'userId']; // Extract the field (e.g., 'userId') from the payload
            print("Decoded senderId: $_senderId");

            // If the value you want is a specific key like 'userId'
            // _senderId = payload['userId'];
            // or any other field you're interested in
          } catch (e) {
            // Handle error if decoding fails
            print('Error decoding token: $e');
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.fullName),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.error != null) {
            // Show snackbar for error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
          // Update UI after successful message send
          _messageController.clear();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Displaying messages
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ListTile(
                          title: Text(message.fullName),
                          subtitle: Text(message.text ?? ''),
                          trailing: Text(
                            _formatDateTime(message.lastMessageTime),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Message input and send button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty &&
                            _senderId != null) {
                          // Send the message only if _senderId is not null
                          final chatEntity = ChatEntity(
                            userId: widget.user.userId,
                            senderId: _senderId!, // Use the decoded senderId
                            receiverId: widget.user.userId,
                            fullName: widget.user.fullName,
                            profilePic: widget.user.profilePic,
                            latestMessage: _messageController.text,
                            lastMessageTime: DateTime.now(),
                            isSeen: false,
                            deletedBy: const [],
                            text: _messageController.text, // Text content
                          );

                          _chatBloc.add(SendMessage(chatEntity: chatEntity));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "No date";
    final formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }
}
