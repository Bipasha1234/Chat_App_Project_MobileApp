// import 'package:cool_app/view/register.dart';
// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<Map<String, String?>> onboardingData = [
//     {
//       "title": "Welcome to Chattix App - A Chat App",
//       "image": "assets/images/chattix.png",
//     },
//     {
//       "image": "assets/images/image1.png",
//       "title": "Instant Messaging",
//       "description": "Chat with friends and family in real time."
//     },
//     {
//       "image": "assets/images/image4.png",
//       "title": "Share Moments",
//       "description": " Share photos, videos, and more with your loved ones.",
//     },
//     {
//       "image": "assets/images/check.png",
//       "title": "Let’s Get Started!",
//       "description": "Create an account and set your profile to begin.",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentPage = index;
//                     });
//                   },
//                   itemCount: onboardingData.length,
//                   itemBuilder: (context, index) {
//                     final image = onboardingData[index]["image"]!;
//                     final title = onboardingData[index]["title"] ?? '';
//                     final description =
//                         onboardingData[index]["description"] ?? '';
//                     return OnboardingContent(
//                       image: image,
//                       title: title,
//                       description: description,
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   onboardingData.length,
//                   (index) => buildDot(index),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: SizedBox(
//                   width: screenWidth > 600 ? 400 : double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _currentPage == onboardingData.length - 1
//                         ? () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const SignUpScreen()),
//                             );
//                           }
//                         : () {
//                             _pageController.nextPage(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.ease,
//                             );
//                           },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(200, 45),
//                       backgroundColor: const Color(0xFF80CBB2),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 24),
//                     ),
//                     child: Text(
//                       _currentPage == onboardingData.length - 1
//                           ? "Get Started"
//                           : "Next",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//             ],
//           ),
//           Positioned(
//             top: 40,
//             right: 20,
//             child: _currentPage != onboardingData.length - 1
//                 ? TextButton(
//                     onPressed: () {
//                       _pageController.jumpToPage(onboardingData.length - 1);
//                     },
//                     child: const Text(
//                       "Skip",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDot(int index) {
//     return GestureDetector(
//       onTap: () {
//         _pageController.animateToPage(
//           index,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.ease,
//         );
//       },
//       child: Container(
//         height: 10,
//         width: _currentPage == index ? 20 : 10,
//         margin: const EdgeInsets.symmetric(horizontal: 5),
//         decoration: BoxDecoration(
//           color: _currentPage == index ? const Color(0xFF80CBB2) : Colors.grey,
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//     );
//   }
// }

// class OnboardingContent extends StatelessWidget {
//   final String image, title, description;

//   const OnboardingContent({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(image, height: 120), // Image at the top
//         const SizedBox(height: 20),
//         if (title.isNotEmpty)
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         const SizedBox(height: 10),
//         if (description.isNotEmpty)
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'package:cool_app/bloc/onboarding_bloc.dart';
// import 'package:cool_app/bloc/onboarding_event.dart';
// import 'package:cool_app/model/onboarding_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OnboardingBloc()..add(OnboardingLoadEvent()),
//       child: Scaffold(
//         body: BlocBuilder<OnboardingBloc, List<OnboardingData>>(
//           builder: (context, onboardingData) {
//             if (onboardingData.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return Column(
//               children: [
//                 Expanded(
//                   child: PageView.builder(
//                     itemCount: onboardingData.length,
//                     onPageChanged: (index) {
//                       context
//                           .read<OnboardingBloc>()
//                           .add(OnboardingJumpToPageEvent(pageIndex: index));
//                     },
//                     itemBuilder: (context, index) {
//                       final data = onboardingData[index];
//                       return OnboardingContent(
//                         title: data.title,
//                         image: data.image,
//                       );
//                     },
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context
//                         .read<OnboardingBloc>()
//                         .add(OnboardingNextPageEvent());
//                   },
//                   child: Text(
//                     context.read<OnboardingBloc>().currentPageIndex ==
//                             onboardingData.length - 1
//                         ? 'Get Started'
//                         : 'Next',
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class OnboardingContent extends StatelessWidget {
//   final String title;
//   final String image;

//   const OnboardingContent(
//       {super.key, required this.title, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(image),
//         Text(title),
//       ],
//     );
//   }
// }

import 'package:cool_app/bloc/onboarding_bloc.dart';
import 'package:cool_app/bloc/onboarding_event.dart';
import 'package:cool_app/bloc/onboarding_state.dart' as onboarding_state;
import 'package:cool_app/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, String?>> onboardingData = [
    {
      "title": "Welcome to Chattix App - A Chat App",
      "image": "assets/images/chattix.png",
    },
    {
      "image": "assets/images/image1.png",
      "title": "Instant Messaging",
      "description": "Chat with friends and family in real time."
    },
    {
      "image": "assets/images/image4.png",
      "title": "Share Moments",
      "description": " Share photos, videos, and more with your loved ones.",
    },
    {
      "image": "assets/images/check.png",
      "title": "Let’s Get Started!",
      "description": "Create an account and set your profile to begin.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => OnboardingBloc(),
        child: BlocBuilder<OnboardingBloc, onboarding_state.OnboardingState>(
          builder: (context, state) {
            final currentPageIndex =
                state is onboarding_state.OnboardingPageChanged
                    ? state.currentPageIndex
                    : 0; // Default to 0 if no state is available.

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          context
                              .read<OnboardingBloc>()
                              .add(OnboardingPageChangedEvent(index));
                        },
                        itemCount: onboardingData.length,
                        itemBuilder: (context, index) {
                          final image = onboardingData[index]["image"]!;
                          final title = onboardingData[index]["title"] ?? '';
                          final description =
                              onboardingData[index]["description"] ?? '';
                          return OnboardingContent(
                            image: image,
                            title: title,
                            description: description,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingData.length,
                        (index) => buildDot(index, currentPageIndex),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width > 600
                            ? 400
                            : double.infinity,
                        child: ElevatedButton(
                          onPressed: currentPageIndex ==
                                  onboardingData.length - 1
                              ? () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  );
                                }
                              : () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 45),
                            backgroundColor: const Color(0xFF80CBB2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                          ),
                          child: Text(
                            currentPageIndex == onboardingData.length - 1
                                ? "Get Started"
                                : "Next",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: currentPageIndex != onboardingData.length - 1
                      ? TextButton(
                          onPressed: () {
                            _pageController
                                .jumpToPage(onboardingData.length - 1);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildDot(int index, int currentPageIndex) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      child: Container(
        height: 10,
        width: currentPageIndex == index ? 20 : 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color:
              currentPageIndex == index ? const Color(0xFF80CBB2) : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image, height: 120), // Image at the top
        const SizedBox(height: 20),
        if (title.isNotEmpty)
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        const SizedBox(height: 10),
        if (description.isNotEmpty)
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
