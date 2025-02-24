import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedUsersPage extends StatelessWidget {
  const BlockedUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blocked Users',
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 20, 20, 20)
            : const Color.fromARGB(255, 117, 198, 171),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => BlocProvider.of<ChatBloc>(context)
          ..add(LoadBlockedUsers()), // Trigger the event to load blocked users
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            // If loading, show a loading indicator
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // If there's an error, show the error message
            if (state.error != null && state.error!.isNotEmpty) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }

            // Display blocked users
            if (state.blockedUsers.isEmpty) {
              return const Center(child: Text('No blocked users.'));
            }

            // Show the list of blocked users
            return ListView.builder(
              itemCount: state.blockedUsers.length,
              itemBuilder: (context, index) {
                final user = state.blockedUsers[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.transparent
                              : Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              user.fullName,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 30),
                            TextButton(
                              onPressed: () {
                                // Logic for unblocking the user goes here
                                BlocProvider.of<ChatBloc>(context)
                                    .add(UnBlockUser(user.userId));
                              },
                              child: const Text(
                                'Unblock',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20, // Red color for unblock text
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
