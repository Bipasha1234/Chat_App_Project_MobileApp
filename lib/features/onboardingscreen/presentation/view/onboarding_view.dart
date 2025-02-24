import 'package:cool_app/features/onboardingscreen/presentation/view_model/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String?>> onboardingData = [
    {
      "image": "assets/images/chattix.png",
    },
    {
      "image": "assets/images/image4.png",
      "title": "Communicate Easily",
      "description": "Send and receive messages in real-time.",
    },
    {
      "image": "assets/images/delete-friend.png",
      "title": "Block the accounts",
      "description":
          "Easily block the people to maintain your privacy and control over your connections.",
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
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
                  (index) => buildDot(index),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: _currentPage == onboardingData.length - 1
                      ? () {
                          print("Onboarding completed!");
                        }
                      : () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width > 600
                          ? 200
                          : double.infinity, // Adjust for tablet
                      MediaQuery.of(context).size.width > 600
                          ? 40
                          : 50, // Smaller height on tablet
                    ),
                    backgroundColor: const Color(0xFF80CBB2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width > 600
                          ? 16
                          : 18, // Adjust text size
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
            child: _currentPage != onboardingData.length - 1
                ? TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(onboardingData.length - 1);
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
      ),
    );
  }

  Widget buildDot(int index) {
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
        width: _currentPage == index ? 20 : 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: _currentPage == index ? const Color(0xFF80CBB2) : Colors.grey,
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
      children: [
        Image.asset(image, height: 130),
        const SizedBox(height: 20),
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 10),
        if (description.isNotEmpty)
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
