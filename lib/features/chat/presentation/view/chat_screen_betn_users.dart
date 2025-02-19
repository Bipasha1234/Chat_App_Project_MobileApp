import 'package:cool_app/app/constants/api_endpoints.dart';
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
    _loadMessages(); // Load messages when the screen is initialized
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

            // Load messages after senderId is fetched
            if (_senderId != null) {
              _loadMessages();
            }
          } catch (e) {
            // Handle error if decoding fails
            print('Error decoding token: $e');
          }
        });
      },
    );
  }

  // Load messages from the server or local storage
  void _loadMessages() {
    if (_senderId != null) {
      // Construct the chatId or use another identifier to get messages
      final chatId =
          widget.user.userId; // Or use another method to generate chatId

      // Trigger the GetMessages event with userId and receiverId (or chatId)
      _chatBloc.add(LoadMessages(chatId));
    }
  }

  void _showUserOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: widget.user.profilePic != null
                  ? NetworkImage(
                      '${ApiEndpoints.imageUrl}/${widget.user.profilePic}')
                  : null,
              child: widget.user.profilePic == null
                  ? const Icon(Icons.person, size: 60, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              widget.user.fullName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Email: ${widget.user.email ?? 'Not available'}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
                foregroundColor: Colors.white, // Text/Icon color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                elevation: 3,
              ).copyWith(
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return Colors.red.shade300; // Light red on hover
                  }
                  return null;
                }),
              ),
              icon: const Icon(Icons.delete, size: 20),
              label: const Text('Delete Chat'),
              onPressed: () {
                // _chatBloc.add(DeleteChat(widget.user.userId));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _showUserOptions, // Show user details on tap
          child: Text(widget.user.fullName),
        ),
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
                        final isSender = message.senderId ==
                            _senderId; // Check if the message is sent by the logged-in user

                        return Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft, // Align based on sender
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: isSender
                                    ? const Color.fromARGB(255, 117, 198, 171)
                                    : Colors.grey[
                                        300], // Different colors for sender and receiver
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: isSender
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment
                                        .start, // Align text based on sender
                                children: [
                                  Text(
                                    message.text ?? '', // Display message text
                                    style: TextStyle(
                                      color: isSender
                                          ? Colors.white
                                          : Colors
                                              .black, // Text color based on sender
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    _formatDateTime(message
                                        .createdAt), // Time of the message
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: isSender
                                          ? Colors.white
                                          : Colors.grey, // Time color
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                            email: widget.user.email,
                            deletedBy: const [],
                            text: _messageController.text, // Text content
                          );

                          _chatBloc.add(SendMessage(chatEntity));
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
