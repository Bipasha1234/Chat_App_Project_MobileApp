import 'package:cool_app/core/common/snackbar/my_snackbar.dart';
import 'package:cool_app/features/chat/presentation/view_model/login/chat_bloc.dart';
import 'package:cool_app/features/home/presentation/view/bottom_view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            leading: const Icon(Icons.account_circle),
                            title: Text(user.fullname),
                            subtitle: Text(user.latestMessage),
                            trailing: IconButton(
                              icon: const Icon(Icons.chat),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Settingsiew(),
                                  ),
                                );
                              },
                            ),
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
