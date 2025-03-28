import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zypto_pulse/providers/theme_provider.dart';
import 'package:zypto_pulse/screens/auth_page.dart';
import 'package:zypto_pulse/screens/home_screen.dart';
import 'package:zypto_pulse/screens/settings_screen.dart';
import 'package:zypto_pulse/screens/splash_screen.dart';
import 'package:zypto_pulse/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ZyptoPulse',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(path: '/', builder: (_, __) => SplashScreen()),
          GoRoute(path: '/auth', builder: (_, __) => AuthPage()),
          GoRoute(path: '/home', builder: (_, __) => HomeScreen()),
          GoRoute(path: '/profile', builder: (_, __) => ProfileScreen()),
        ],
      ),
    );
  }
}
