import 'package:cool_app/features/auth/presentation/view/register_view.dart';
import 'package:cool_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  final _gap = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2),
        elevation: 0,
        leading: null,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          color: Colors.white,
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login to your Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      _gap,
                      TextFormField(
                        key: const ValueKey('email'),
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 56, 55, 55)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                      ),
                      _gap,
                      TextFormField(
                        key: const ValueKey('password'),
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 56, 55, 55)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      _gap,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFF80CBB2),
                          shadowColor: Colors.grey.withOpacity(0.3),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginUserEvent(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    destination: const RegisterView(),
                                    context: context,
                                  ),
                                );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an Account? ",
                              style: TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
