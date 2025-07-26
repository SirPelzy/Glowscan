import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Subscription', style: AppTheme.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text('Current Plan', style: AppTheme.heading2),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(8)),
                child: Center(child: SvgPicture.asset('assets/images/star.svg', width: 24, height: 24)),
              ),
              title: const Text('GlowScan Basic', style: AppTheme.bodyText),
              subtitle: Text('Free', style: AppTheme.subtitle.copyWith(fontSize: 14)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "You're currently on the free plan. Upgrade to Premium for unlimited scans, personalized routines, and exclusive content.",
                style: AppTheme.bodyText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text('Upgrade Options', style: AppTheme.heading2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildPlanCard(
                    title: 'Monthly',
                    price: '\$9.99',
                    period: '/month',
                    onPressed: () { /* TODO: Initiate monthly subscription */ },
                  ),
                  const SizedBox(height: 16),
                  _buildPlanCard(
                    title: 'Yearly',
                    price: '\$59.99',
                    period: '/year',
                    isBestValue: true,
                    onPressed: () { /* TODO: Initiate yearly subscription */ },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required VoidCallback onPressed,
    bool isBestValue = false,
  }) {
    final features = [
      'Unlimited scans',
      'Personalized routines',
      'Exclusive content',
      'Priority support',
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold)),
              if (isBestValue)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE3E79),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Best Value', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(price, style: AppTheme.heading1.copyWith(fontSize: 36)),
              const SizedBox(width: 4),
              Text(period, style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.surface,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
              child: const Text('Upgrade', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) => _FeatureListItem(text: feature)).toList(),
        ],
      ),
    );
  }
}

class _FeatureListItem extends StatelessWidget {
  final String text;
  const _FeatureListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/check.svg', width: 20, height: 20),
          const SizedBox(width: 12),
          Text(text, style: AppTheme.bodyText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
