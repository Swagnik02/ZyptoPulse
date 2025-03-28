import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zypto_pulse/providers/auth_provider.dart';
import 'package:zypto_pulse/screens/login_screen.dart';
import 'package:zypto_pulse/screens/signup_screen.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1B232A),
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/constelllations.png'),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    _buildTab(context, ref, "Sign in", authState.isSignIn),
                    _buildTab(context, ref, "Sign up", !authState.isSignIn),
                  ],
                ),
                const SizedBox(height: 30),
                authState.isSignIn ? const LoginScreen() : const SignUpScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    WidgetRef ref,
    String text,
    bool isActive,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => ref.read(authProvider.notifier).toggleAuth(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.black54 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(isActive ? 1.0 : 0.5),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
