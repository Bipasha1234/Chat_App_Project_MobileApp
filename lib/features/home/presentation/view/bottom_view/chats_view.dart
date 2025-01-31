import 'package:flutter/material.dart';

// Chat model to represent each user in the chat list
class ChatUser {
  final String name;
  final String message;
  final String avatarUrl;
  final DateTime lastMessageTime;

  ChatUser({
    required this.name,
    required this.message,
    required this.avatarUrl,
    required this.lastMessageTime,
  });
}

class ChatsView extends StatelessWidget {
  ChatsView({super.key});

  // List of dummy chat users
  final List<ChatUser> chatUsers = [
    ChatUser(
      name: 'Johni Sherpa',
      message: 'Hey, how are you?',
      avatarUrl: '',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatUser(
      name: 'Jane Rana',
      message: 'Are we meeting tomorrow?',
      avatarUrl: '',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatUser(
      name: 'Ram Sherpa',
      message: 'Good morning!',
      avatarUrl: '',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatUser(
      name: 'Hari Sharma',
      message: 'Good morning!',
      avatarUrl: '',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ChatUser(
      name: 'Sachina Karki',
      message: 'Good morning!',
      avatarUrl: '',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ChatUser(
      name: 'Bipasha Lamsal',
      message: 'Good morning!',
      avatarUrl: '',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 245, 242, 242)),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 250, 250, 250),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatUsers.length,
              itemBuilder: (context, index) {
                final chatUser = chatUsers[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chatUser.avatarUrl),
                  ),
                  title: Text(chatUser.name),
                  subtitle: Text(
                    chatUser.message,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${chatUser.lastMessageTime.hour}:${chatUser.lastMessageTime.minute.toString().padLeft(2, '0')}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Implement chat screen navigation here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
