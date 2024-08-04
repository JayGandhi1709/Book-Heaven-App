import 'package:book_heaven/screens/auth/provider/user_provider.dart';
import 'package:book_heaven/screens/auth/widgets/custom_text_field.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _namecontroller = TextEditingController(text: "");
  // TextEditingController(text: "Jay Gandhi");
  final TextEditingController _emailcontroller =
      TextEditingController(text: "");
  // TextEditingController(text: "gandhijay126@gmail.com");
  final TextEditingController _passwordcontroller =
      TextEditingController(text: "");
  // TextEditingController(text: "12345678");
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController(text: "");
  // TextEditingController(text: "12345678");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmPasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  labelText: "Name",
                  controller: _namecontroller,
                ),
                CustomTextField(
                  labelText: "Email",
                  controller: _emailcontroller,
                ),
                CustomTextField(
                  labelText: "Password",
                  controller: _passwordcontroller,
                  obscureText: true,
                ),
                CustomTextField(
                  labelText: "Confirm Password",
                  controller: _confirmPasswordcontroller,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_passwordcontroller.text !=
                          _confirmPasswordcontroller.text) {
                        showSnackBar("Passwords do not match!", MsgType.error);
                        return;
                      }
                      context.userProvider.register(
                        name: _namecontroller.text,
                        email: _emailcontroller.text.trim(),
                        password: _passwordcontroller.text.trim(),
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
                // dont haven't account by not using Row
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.deepPurple,
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

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     required this.labelText,
//     required this.controller,
//     this.obscureText = false,
//   });

//   final String labelText;
//   final TextEditingController controller;
//   final bool obscureText;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: 'Enter your $labelText',
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your $labelText';
//         }
//         return null;
//       },
//     );
//   }
// }
