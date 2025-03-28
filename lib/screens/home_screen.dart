import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zypto_pulse/screens/nav/favourite_screen.dart';
import 'package:zypto_pulse/screens/nav/market_screen.dart';
import 'package:zypto_pulse/screens/nav/other_screen.dart';
import 'package:zypto_pulse/widgets/floating_nav_bar.dart';
import 'package:zypto_pulse/widgets/svg_icon_button.dart';

final navigationProvider = StateNotifierProvider<NavigationController, int>(
  (ref) => NavigationController(),
);

class NavigationController extends StateNotifier<int> {
  NavigationController() : super(1);

  void updateIndex(int newIndex) => state = newIndex;
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/profile');
          },
          icon: Icon(Icons.person),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          SvgIconButton(assetPath: "assets/icons/search.svg", onPressed: () {}),
          SizedBox(width: 4),
          SvgIconButton(
            assetPath: "assets/icons/scanner.svg",
            onPressed: () {},
          ),
          SizedBox(width: 4),
          SvgIconButton(
            assetPath: "assets/icons/notifications.svg",
            onPressed: () {},
          ),
          SizedBox(width: 8),
        ],
        elevation: 1,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeTab(),
          MarketsScreen(),
          TradesScreen(),
          FavouritesScreen(),
          WalletsScreen(),
        ],
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: currentIndex,
        onTap:
            (index) => ref.read(navigationProvider.notifier).updateIndex(index),
        iconPaths: [
          'assets/icons/home.svg',
          'assets/icons/markets.svg',
          'assets/icons/trades.svg',
          'assets/icons/favs.svg',
          'assets/icons/wallet.svg',
        ],
        labels: ['Home', 'Markets', 'Trades', 'Favourites', 'Wallets'],
      ),
    );
  }
}
