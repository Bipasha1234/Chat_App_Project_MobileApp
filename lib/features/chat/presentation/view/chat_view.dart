import 'package:cool_app/app/constants/api_endpoints.dart';
import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/core/common/snackbar/my_snackbar.dart';
import 'package:cool_app/features/chat/presentation/view/chat_screen_betn_users.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadGetUser());
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "No date";

    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
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
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.error != null) {
            // Show snackbar outside the build phase
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showMySnackBar(
                context: context,
                message: state.error!,
                color: Colors.red,
              );
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.users.isEmpty) {
                      return const Center(child: Text('No users available.'));
                    } else {
                      return ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (BuildContext context, index) {
                          final user = state.users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius:
                                  25, // Adjust the radius to your preference
                              backgroundImage: user.profilePic.isNotEmpty
                                  ? NetworkImage(
                                      '${ApiEndpoints.imageUrl}/${user.profilePic}')
                                  : const AssetImage(
                                      'assets/images/user.png'), // Fallback to local asset image

                              backgroundColor:
                                  Colors.grey[200], // Default color if no image
                            ),
                            title: Text(user.fullName),
                            subtitle: Text(user.latestMessage),
                            trailing: Text(
                              _formatDateTime(user
                                  .lastMessageTime), // Display formatted latest message time
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            onTap: () {
                              // Navigate to the chat screen for the selected user
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => getIt<ChatBloc>(),
                                    child: ChatScreen(
                                      user: user,
                                      // Pass the user to the chat screen
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
