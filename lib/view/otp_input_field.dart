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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        controllers
            .length, // Automatically create as many fields as controllers
        (index) => SizedBox(
          width: isTablet ? 50 : 40,
          child: TextField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '', // Removes the character counter
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(
                      255, 218, 217, 217), // Light grey border color
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: const Color.fromARGB(
                  255, 247, 244, 244), // Light background color
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              // Optional: add dashed border effect (You can add this in custom design)
              // Using BoxDecoration to add dashed borders is possible too.
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < controllers.length - 1) {
                FocusScope.of(context).nextFocus(); // Move to the next field
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context)
                    .previousFocus(); // Move to the previous field
              }
            },
          ),
        ),
      ),
    );
  }
}
