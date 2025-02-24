import 'package:cool_app/app/constants/api_endpoints.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsScreen extends StatelessWidget {
  final ChatEntity user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Set the back button color to white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 20, 20, 20)
            : const Color.fromARGB(255, 117, 198, 171),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 94, 79, 79)
              : Colors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: user.profilePic.isNotEmpty
                    ? NetworkImage(
                        '${ApiEndpoints.imageUrl}/${user.profilePic}')
                    : const AssetImage('assets/images/user.png'),
              ),
              const SizedBox(height: 20),
              Text(
                user.fullName,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${user.email ?? 'Not available'}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Delete Chat Button with container style
              SizedBox(
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1), // Light red background
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      textStyle: const TextStyle(fontSize: 22),
                      backgroundColor: Colors.transparent,
                    ),
                    icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                    label: const Text('Delete Chat',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      chatBloc.add(DeleteChat(user.userId));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Block User Button with container style
              SizedBox(
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1), // Light red background
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      textStyle: const TextStyle(fontSize: 22),
                      backgroundColor: Colors.transparent,
                    ),
                    icon: const Icon(Icons.block, color: Colors.red, size: 28),
                    label: const Text('Block User',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      chatBloc.add(BlockUser(user.userId));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
