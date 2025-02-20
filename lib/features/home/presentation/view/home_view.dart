// import 'package:cool_app/core/common/snackbar/my_snackbar.dart';
// import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
// import 'package:cool_app/features/home/presentation/view_model/home_cubit.dart';
// import 'package:cool_app/features/home/presentation/view_model/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key, required AuthEntity user});

//   final bool _isDarkTheme = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chattix'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               // Logout code
//               showMySnackBar(
//                 context: context,
//                 message: 'Logging out...',
//                 color: Colors.red,
//               );

//               context.read<HomeCubit>().logout(context);
//             },
//           ),
//           Switch(
//             value: _isDarkTheme,
//             onChanged: (value) {
//               // Change theme
//               // setState(() {
//               //   _isDarkTheme = value;
//               // });
//             },
//           ),
//         ],
//       ),
//       // body: _views.elementAt(_selectedIndex),
//       body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
//         return state.views.elementAt(state.selectedIndex);
//       }),
//       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           return BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.chat),
//                 label: 'Chats',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.group),
//                 label: 'Groups',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.face),
//                 label: 'Profile',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.settings),
//                 label: 'Settings',
//               ),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.white,
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:cool_app/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  final AuthEntity user;

  const HomeView({super.key, required this.user}); // Pass user data to HomeView

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(user), // Initialize HomeCubit with user
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Chattix',
                style: TextStyle(fontSize: 23),
              ),
              centerTitle: true,
            ),
            body: state.views[state.selectedIndex], // Show the selected tab
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), label: 'Groups'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.face), label: 'Profile'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
              currentIndex: state.selectedIndex,
              selectedItemColor: Colors.white,
              onTap: (index) => context.read<HomeCubit>().onTabTapped(index),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
// import 'package:flutter/material.dart';

// class HomeView extends StatelessWidget {
//   final AuthEntity user;

//   const HomeView(
//       {super.key, required this.user}); // Accept user data as parameter

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () {
//               // Handle logout here
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Full Name: ${user.fullName}',
//                 style: const TextStyle(fontSize: 20)),
//             Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logout or other actions
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
