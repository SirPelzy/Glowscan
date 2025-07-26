import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening links

// Placeholder model for a Product.
// This should match the model in your 'core/models/product.dart' file.
class Product {
  final String name;
  final String description;
  final String imageUrl;
  final String affiliateLink;
  final bool isBestSeller;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.affiliateLink,
    this.isBestSeller = false,
  });
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // Mock data - This should be fetched from `/api/products/recommendations`
  final List<Product> products = const [
    Product(name: 'Hydrating Serum', description: 'A lightweight serum that deeply hydrates and plumps the skin, reducing the appearance of fine lines.', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC7tunkYenZM22htUe1f0oQm16denJJFbUZz5qbuuR4N0zT513NAgt-uCTCXXscpF6NFzcAB87pgLJwwM31ZQ9DA5wgiT3boThUQkZT-YEOqezNYD6sbi8WWCOEITEJni0ZeCaj6DxmLFN1kopGDtWTaZm1-tGzkO7Hx37B_IrPZP7q_i9D8E3mzxDbLOc31h4BUoJfw6cmOceYSemABYH17IAEEnmItOl558jQFTSkydSMW0gO4E2rtxiDjy6QUVEKkqzh1bzTMZPW', affiliateLink: 'https://example.com/aff/b2', isBestSeller: true),
    Product(name: 'Gentle Cleanser', description: 'A mild cleanser that effectively removes makeup and impurities without stripping the skin\'s natural oils.', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAllm7mxmBCA7SaU1X1qd10ieEWZKWqKFK9ZksAgamSWAjJS5kz0pkHqrEEQlt8rrVvVij4Hu0IkVXA58AhaApa-LTIyVmXvSDkpceh6cS9bQi1AEgy5ORF4BoS0cVEN6hbRxqa4jNFiw323r8S88ooZ38_w0iGOx93SY0Qbop6utd6AJiW200obQWaTFlaEm7XBet0WOL11lUVsT9687S3yBhK_qE_ncFpp7r3DuH_PLL8pKRf9Mg4Y0dWsWhiH-_S6G32RHl53Q7t', affiliateLink: 'https://example.com/aff/b1'),
    Product(name: 'Daily Moisturizer', description: 'A non-comedogenic moisturizer that provides long-lasting hydration and protects the skin from environmental stressors.', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCNEs90M_22R8xIwzfgD6njhDgw-PkE-I5FDVSOEt6DT8CJz0cUbh_a_vPJqy5IL6hNLqZc9QMCwBzmmD2DxgZtPsVn-LKf4Eww4C7sEyoPCrTllc6yfjvc9X9ocSTFlQBP-p64hrX-q2hu-ZFvkNrOsadBbLJ0GltEhIdd1AssOTc5UCBtbPOmrWqgOx7j8uDhnrYhx12CuHzxeMPK7qeXu0C5Uni_6mLr-6NcS55q7NXtOwPVRiV7nZsBsI5bwSMJPh5cp-YjAeFk', affiliateLink: 'https://example.com/aff/b3'),
    Product(name: 'Sunscreen SPF 30', description: 'A broad-spectrum sunscreen that shields the skin from harmful UV rays, preventing premature aging.', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLIdtmWBxBJZBvabNwnYFpqU6UtGhdAfVDMFJ-W2t3DbOy38iwzaovwUFJGQ-hZQ7OcuEfyfFJ09EFOb-LxLDbrv6cQXmu0098zvS07LE2pFh50RT8tUg2huIqRnsMoNsw4mlM6N-Bx8IUnaRjH2UulonyCWwyT4Aaai-QpJsbWVURZ35A8yj1qaCBWtH6G4Yb8VT2FpXYP__y7JHkgdarQXQ6kGQKb4NZNB4OA4k24sy3_FlYjFtvdkAvXh8bP5hqBZtHrwle2eBj', affiliateLink: 'https://example.com/aff/s1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Recommended Products', style: AppTheme.heading2),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.isBestSeller)
                  Text('Best Seller', style: AppTheme.subtitle.copyWith(fontSize: 14)),
                Text(product.name, style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(product.description, style: AppTheme.subtitle.copyWith(fontSize: 14)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _launchURL(product.affiliateLink),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.surface,
                    foregroundColor: AppTheme.textPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Buy Now', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                )
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
