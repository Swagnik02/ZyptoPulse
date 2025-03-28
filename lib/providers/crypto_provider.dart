import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zypto_pulse/models/crypto_model.dart';
import 'package:zypto_pulse/services/api_service.dart';
import 'package:zypto_pulse/services/favorite_service.dart';

// Riverpod Provider for Crypto Data
final cryptoProvider = StateNotifierProvider<CryptoNotifier, CryptoState>((
  ref,
) {
  return CryptoNotifier(ref);
});

// State class to hold crypto data
class CryptoState {
  final List<CryptoModel> cryptoList;
  final List<CryptoModel> favoriteList;
  final bool isLoading;
  final String? errorMessage;

  CryptoState({
    required this.cryptoList,
    required this.favoriteList,
    required this.isLoading,
    this.errorMessage,
  });

  // Factory method for initial state
  factory CryptoState.initial() =>
      CryptoState(cryptoList: [], favoriteList: [], isLoading: false);
}

// Notifier class to manage crypto state
class CryptoNotifier extends StateNotifier<CryptoState> {
  final Ref _ref; // ✅ Change Reader to Ref

  CryptoNotifier(this._ref) : super(CryptoState.initial()) {
    fetchCryptos();
  }

  Future<void> fetchCryptos({
    String vsCurrency = "usd",
    String order = "market_cap_desc",
    int perPage = 20,
    int pageNum = 1,
    bool sparkline = false,
  }) async {
    state = CryptoState(
      cryptoList: state.cryptoList,
      favoriteList: state.favoriteList,
      isLoading: true,
    );

    try {
      final responseData = await _ref
          .read(apiServiceProvider)
          .fetchMarketData(
            vsCurrency: vsCurrency,
            order: order,
            perPage: perPage,
            pageNum: pageNum,
            sparkline: sparkline,
          );

      final cryptos =
          responseData.map((json) => CryptoModel.fromJson(json)).toList();

      state = CryptoState(
        cryptoList: cryptos,
        favoriteList: state.favoriteList,
        isLoading: false,
      );
    } catch (e) {
      state = CryptoState(
        cryptoList: [],
        favoriteList: state.favoriteList,
        isLoading: false,
        errorMessage: "Failed to load data: $e",
      );
    }
  }

  /// Fetch Favorite Cryptos
  Future<void> fetchFavorites(String token) async {
    try {
      final responseData = await _ref
          .read(favoriteServiceProvider)
          .getFavorites(token);

      final favorites =
          responseData.map((json) => CryptoModel.fromJson(json)).toList();

      state = CryptoState(
        cryptoList: state.cryptoList,
        favoriteList: favorites,
        isLoading: false,
      );
    } catch (e) {
      state = CryptoState(
        cryptoList: state.cryptoList,
        favoriteList: [],
        isLoading: false,
        errorMessage: "Failed to load favorites: $e",
      );
    }
  }

  /// Add Crypto to Favorites
  Future<void> addToFavorites(String token, CryptoModel crypto) async {
    final cryptoData = crypto.toJson();

    final success = await _ref
        .read(favoriteServiceProvider)
        .saveFavorite(token, cryptoData);
    if (success) {
      state = CryptoState(
        cryptoList: state.cryptoList,
        favoriteList: [...state.favoriteList, crypto],
        isLoading: false,
      );
    }
  }

  /// Remove Crypto from Favorites
  Future<void> removeFromFavorites(String token, String itemId) async {
    final success = await _ref
        .read(favoriteServiceProvider)
        .deleteFavorite(token, itemId);
    if (success) {
      state = CryptoState(
        cryptoList: state.cryptoList,
        favoriteList:
            state.favoriteList.where((item) => item.id != itemId).toList(),
        isLoading: false,
      );
    }
  }

  Future<void> addDummyFavourites() async {
    CryptoModel fav1 = CryptoModel(
      id: "tether",
      name: "Tether",
      symbol: "usdt",
      image:
          "https://coin-images.coingecko.com/coins/images/325/large/Tether.png?1696501661",
      currentPrice: 0.999689,
      marketCapRank: 3,
      priceChangePercentage24h: -0.04405,
    );

    CryptoModel fav2 = CryptoModel(
      id: "bitcoin",
      name: "Bitcoin",
      symbol: "btc",
      image:
          "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
      currentPrice: 85193,
      marketCapRank: 1,
      priceChangePercentage24h: -2.68172,
    );

    // Add dummy favorites
    state = CryptoState(
      cryptoList: state.cryptoList,
      favoriteList: [fav1, fav2],
      isLoading: false,
    );
  }
}

// API Service Provider
final apiServiceProvider = Provider<CryptoApiService>((ref) {
  return CryptoApiService();
});

// Favorite Service Provider
final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  return FavoriteService();
});
