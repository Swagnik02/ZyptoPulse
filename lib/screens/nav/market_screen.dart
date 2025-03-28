import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zypto_pulse/providers/crypto_provider.dart';
import 'package:zypto_pulse/widgets/crypto_card.dart';

class MarketsScreen extends ConsumerWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptoState = ref.watch(cryptoProvider);

    return cryptoState.isLoading
        ? Center(child: CircularProgressIndicator())
        : cryptoState.cryptoList.isEmpty
        ? Center(
          child: Text(
            "No data available",
            style: TextStyle(color: Colors.white),
          ),
        )
        : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cryptoState.cryptoList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CryptoCard(
                  crypto: cryptoState.cryptoList[index],
                  onAddToFavorites: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    color: const Color.fromARGB(10, 255, 255, 255),
                    thickness: 1,
                  ),
                ),
              ],
            );
          },
        );
  }
}
