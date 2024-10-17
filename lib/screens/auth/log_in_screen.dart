import 'package:book_heaven/screens/auth/sign_up_screen.dart';
import 'package:book_heaven/screens/auth/widgets/custom_text_field.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller =
      // TextEditingController(text: "");
      TextEditingController(text: "user@gmail.com");
  final TextEditingController _passwordcontroller =
      // TextEditingController(text: "");
      TextEditingController(text: "123456789");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await context.userController.login(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset("assets/splashlogo.png"),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Book Heaven',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  labelText: "Email",
                  controller: _emailcontroller,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: "Password",
                  controller: _passwordcontroller,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: handleLogin,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: context.theme.colorScheme.primary,
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                // dont haven't account by not using Row
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    InkWell(
                      onTap: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: context.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
