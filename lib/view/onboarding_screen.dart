import 'package:cool_app/view/register.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/image1.jpg",
      "title": "Welcome to MyApp",
      "description": "Discover the best way to manage your tasks efficiently.",
    },
    {
      "image": "assets/images/image2.jpg",
      "title": "Stay Organized",
      "description": "Keep track of your goals and stay on top of your priorities.",
    },
    {
      "image": "assets/images/image3.jpg",
      "title": "Achieve More",
      "description": "Accomplish your dreams and make every day productive.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]["image"]!,
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => buildDot(index),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
     onPressed: _currentPage == onboardingData.length - 1
    ? () {
        // Navigate to the Login Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );
      }
    : () {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _currentPage == onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 100),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the Main App!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
