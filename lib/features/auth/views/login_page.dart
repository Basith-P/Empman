import 'package:empman/core/constants.dart';
import 'package:empman/core/env.dart';
import 'package:empman/core/utils/functions.dart';
import 'package:empman/core/utils/widgets/loaders.dart';
import 'package:empman/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogingPage extends StatefulWidget {
  const LogingPage({super.key});

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      if (_emailController.text != adminEmail ||
          _passwordController.text != adminPassword) {
        showSnackBar("Invalid credentials");
        return;
      }

      setState(() => isLoading = true);

      Future.delayed(const Duration(seconds: 1)).then((value) async {
        try {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedin', true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const MainLayout()));
        } catch (e) {
          debugPrint(e.toString());
          showSnackBar('Something went wrong!');
        } finally {
          if (mounted) setState(() => isLoading = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? loaderPrimary
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Login",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                kinputDecoration.copyWith(labelText: "Email"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: kinputDecoration.copyWith(
                                labelText: "Password"),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  FilledButton(onPressed: submit, child: const Text("Login")),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
