import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141A22),
      appBar: AppBar(
        backgroundColor: Color(0xFF141A22),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSettingsTile(
            icon: LucideIcons.globe,
            title: "Language",
            subtitle: "English",
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: LucideIcons.moon,
            title: "Appearance",
            subtitle: "Use Device Settings",
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: LucideIcons.gift,
            title: "About Us",
            subtitle: "v1.0.0",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Icon(icon, color: Colors.tealAccent),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}
