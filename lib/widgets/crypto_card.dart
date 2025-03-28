import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zypto_pulse/models/crypto_model.dart';
import 'package:lottie/lottie.dart';

class CryptoCard extends StatefulWidget {
  final CryptoModel crypto;
  final VoidCallback onAddToFavorites;

  const CryptoCard({
    super.key,
    required this.crypto,
    required this.onAddToFavorites,
  });

  @override
  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  double _dragX = 0.0;
  static const double _threshold = 130;
  bool _hasAnimated = false;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX = (_dragX + details.primaryDelta!).clamp(0.0, 150.0);
    });

    if (_dragX >= _threshold && !_hasAnimated) {
      _hasAnimated = true;
      widget.onAddToFavorites();
      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _hasAnimated = false);
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      _dragX = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Animation (Favorite Indicator)
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Lottie.asset(
                'assets/icons/addToFav.json',
                width: 50,
                height: 50,
                animate: _hasAnimated,
              ),
            ),
          ),
        ),

        // Swipeable Card
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(_dragX, 0, 0),
          child: GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1B232A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Crypto Image & Name
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            widget.crypto.image != null
                                ? NetworkImage(widget.crypto.image!)
                                : null,
                        radius: 20,
                        child:
                            widget.crypto.image == null
                                ? const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                )
                                : null,
                      ),
                      const SizedBox(width: 13),
                      // Name & Symbol
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.crypto.name ?? "Unknown",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            widget.crypto.symbol?.toUpperCase() ?? "--",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Graph Indicator
                  SvgPicture.asset(
                    (widget.crypto.priceChangePercentage24h ?? 0) >= 0
                        ? 'assets/green.svg'
                        : 'assets/red.svg',
                    width: 120,
                    height: 30,
                    fit: BoxFit.fitHeight,
                  ),

                  // Price & Percentage Change
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.crypto.currentPrice != null
                            ? "\$${widget.crypto.currentPrice!.toStringAsFixed(2)}"
                            : "N/A",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.crypto.priceChangePercentage24h != null
                            ? "${widget.crypto.priceChangePercentage24h!.toStringAsFixed(2)}%"
                            : "N/A",
                        style: TextStyle(
                          color:
                              (widget.crypto.priceChangePercentage24h ?? 0) >= 0
                                  ? Colors.green
                                  : Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
