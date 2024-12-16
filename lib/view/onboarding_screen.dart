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

  final List<Map<String, String?>> onboardingData = [
    {
      "image": "assets/images/chattix.png",
      // No title or description for this item
    },
    {
      "image": "assets/images/image1.png",
      "title": "Group Chatting",
      "description": "Connect with multiple members in group chats.",
    },
    {
      "image": "assets/images/image4.png",
      "title": "Communicate Easily",
      "description": "Send and receive messages instantly.",
    },
  ];

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
                    // Provide default empty values if title or description doesn't exist
                    final image = onboardingData[index]["image"]!;
                    final title = onboardingData[index]["title"] ?? '';
                    final description = onboardingData[index]["description"] ?? '';
                    
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: _currentPage == onboardingData.length - 1
                      ? () {
                          // Navigate to the Register Screen
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
                      color: Colors.white, fontSize: 18// Set text color to white for better contrast
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: _currentPage != onboardingData.length - 1
                ? TextButton(
                    onPressed: () {
                      // Jump to the last page
                      _pageController.jumpToPage(onboardingData.length - 1);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
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
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      child: Container(
        height: 10,
        width: _currentPage == index ? 20 : 10,
        margin: EdgeInsets.symmetric(horizontal: 5),
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
        SizedBox(height: 20),
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(height: 10),
        if (description.isNotEmpty)
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
