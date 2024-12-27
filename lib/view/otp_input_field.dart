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
        controllers.length,
        (index) => SizedBox(
          width: isTablet ? 50 : 40,
          child: TextField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 218, 217, 217),
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 247, 244, 244),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < controllers.length - 1) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
