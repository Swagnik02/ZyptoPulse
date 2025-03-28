import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zypto_pulse/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    Future.microtask(() async {
      final authNotifier = ref.read(authProvider.notifier);

      debugPrint("Loading user...");
      await authNotifier.loadUser(); // This might be failing

      if (!mounted) return;

      debugPrint("User loaded. Checking authentication...");

      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;

        final isAuthenticated = ref.read(authProvider).isAuthenticated;
        debugPrint("User Authenticated: $isAuthenticated");
        // Navigate using GoRouter
        if (isAuthenticated) {
          context.go('/home'); // Go to home screen
        } else {
          context.go('/auth'); // Go to auth screen
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1B232A),
              Color(0xFF1B232A),
              Color(0xFF304F4B),
              Color(0xFF5ED5A8),
            ],
            stops: [0.0, 0.75, 0.88, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(image: AssetImage('assets/stars.png'), fit: BoxFit.cover),
            Image(
              image: AssetImage('assets/constelllations.png'),
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(image: AssetImage('assets/logo.png'), height: 80),
                  SizedBox(height: 20),
                  Text(
                    "ZyptoPulse",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5ED5A8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
