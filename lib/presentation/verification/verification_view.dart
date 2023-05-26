import 'package:flutter/material.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Check your \n Email',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      "",
                      // 'We have sent you a Email on  ${auth.currentUser?.email}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'Verifying email....',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 57),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    child: const Text('Resend'),
                    onPressed: () {
                      // try {
                      //   FirebaseAuth.instance.currentUser
                      //       ?.sendEmailVerification();
                      // } catch (e) {
                      //   debugPrint('$e');
                      // }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
