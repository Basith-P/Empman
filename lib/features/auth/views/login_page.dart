import 'package:emplman/core/constants.dart';
import 'package:emplman/core/env.dart';
import 'package:emplman/core/utils/functions.dart';
import 'package:emplman/views/main_layout.dart';
import 'package:flutter/material.dart';

class LogingPage extends StatefulWidget {
  const LogingPage({super.key});

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

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

      Future.delayed(const Duration(seconds: 1)).then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const MainLayout())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Login", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: kinputDecoration.copyWith(labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          kinputDecoration.copyWith(labelText: "Password"),
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
