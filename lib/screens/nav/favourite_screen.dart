import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zypto_pulse/providers/crypto_provider.dart';
import 'package:zypto_pulse/widgets/favourite_card.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptoState = ref.watch(cryptoProvider);

    return cryptoState.favoriteList.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  ref.read(cryptoProvider.notifier).addDummyFavourites();
                },
                child: Text(
                  'Add Dummy Favourites',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text("No favorites added", style: TextStyle(color: Colors.white)),
            ],
          ),
        )
        : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cryptoState.favoriteList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                FavouriteCard(crypto: cryptoState.favoriteList[index]),
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
