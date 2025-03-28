import 'package:flutter/material.dart';
import 'package:zypto_pulse/models/crypto_model.dart';
import 'package:intl/intl.dart';

class FavouriteCard extends StatelessWidget {
  final CryptoModel crypto;

  const FavouriteCard({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crypto Icon
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage:
                crypto.image != null ? NetworkImage(crypto.image!) : null,
            radius: 20,
            child:
                crypto.image == null
                    ? const Icon(Icons.image_not_supported, color: Colors.grey)
                    : null,
          ),
          const SizedBox(width: 10),
          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      crypto.symbol!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Market Cap Rank",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      crypto.marketCapRank.toString(),
                      style: const TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      crypto.currentPrice.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price Change Percentage 24h",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      "${crypto.priceChangePercentage24h?.toStringAsFixed(2)}%",
                      style: TextStyle(
                        color:
                            crypto.priceChangePercentage24h! < 0
                                ? Colors.red
                                : Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
