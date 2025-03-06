import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmEmailScreen extends StatelessWidget {
  final String? email = Get.parameters['email'];

  ConfirmEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Your Email'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mail_outline,
                size: 64,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              Text(
                'Verification Email Sent',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent a verification email to:\n${email ?? "your email address"}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const Text(
                'Please check your email and click the verification link to continue.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.offAllNamed('/login'),
                child: const Text('Return to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
