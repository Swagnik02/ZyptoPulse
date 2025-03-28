import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B232A),
      body: Center(
        child: Text("Home Screen", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class TradesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B232A),
      body: Center(
        child: Text("Trades Screen", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class WalletsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B232A),
      body: Center(
        child: Text("Wallets Screen", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
