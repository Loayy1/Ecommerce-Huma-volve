import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductBottom extends StatelessWidget {
  final String productid;
  const ShareProductBottom({super.key, required this.productid});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final productLink = 'https://example.com/products/$productid';
        final String shareMsg = 'Check out this product: $productLink';
        await SharePlus.instance.share(
          ShareParams(
            text: shareMsg,
            subject: 'Check out this product',
          ),
        );
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.share, size: 18, color: Colors.black87),
      ),
    );
  }
}
