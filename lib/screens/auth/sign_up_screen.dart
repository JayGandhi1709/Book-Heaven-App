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
  final TextEditingController _emailcontroller =
      TextEditingController(text: "");
  final TextEditingController _passwordcontroller =
      TextEditingController(text: "");
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController(text: "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 100,
                            child: Image.asset("assets/splashlogo.png"),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 50),
                          CustomTextField(
                            labelText: "Name",
                            controller: _namecontroller,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            labelText: "Email",
                            controller: _emailcontroller,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            labelText: "Password",
                            controller: _passwordcontroller,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            labelText: "Confirm Password",
                            controller: _confirmPasswordcontroller,
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          _isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor:
                                        context.theme.colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      if (_passwordcontroller.text !=
                                          _confirmPasswordcontroller.text) {
                                        showSnackBar("Passwords do not match!",
                                            MsgType.error);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        return;
                                      }
                                      context.userController.register(
                                        name: _namecontroller.text,
                                        email: _emailcontroller.text.trim(),
                                        password:
                                            _passwordcontroller.text.trim(),
                                      );
                                    }
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Get.back();
                                    });
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account? "),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: context.theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
