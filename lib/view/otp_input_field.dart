import 'package:flutter/material.dart';

class OtpInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final bool isTablet;

  const OtpInputField({
    super.key,
    required this.controllers,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 5.0), // Reduced horizontal padding
          child: SizedBox(
            width: isTablet
                ? MediaQuery.of(context).size.width * 0.1
                : MediaQuery.of(context).size.width * 0.12, // Adjusted width
            child: TextField(
              controller: controllers[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: "",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black), // Black border
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black), // Black border
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < 3) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
