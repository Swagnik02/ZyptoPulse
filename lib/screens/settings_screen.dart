import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zypto_pulse/providers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("English"),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text("Appearance"),
            trailing: Switch(
              value: isDarkMode,
              onChanged:
                  (value) => ref.read(themeProvider.notifier).toggleTheme(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About Us"),
            trailing: const Text("v1.2.3"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
