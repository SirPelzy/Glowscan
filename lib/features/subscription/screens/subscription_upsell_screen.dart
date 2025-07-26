import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';

class SubscriptionUpsellScreen extends StatelessWidget {
  const SubscriptionUpsellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/x-close.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('GlowScan Premium', style: AppTheme.heading2),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCLy_bgy9DpIKpNpIkBl6zvI3eiCsCU767TZEyBrjn8eTpheUd1z24b8rBh4RZz_rc3_M0hHtvSqEiLFun2aFKgOT_OX9oaCrPvlEGIX-HTwYHoPKFlTdE4PlRN_XjOdWf9T2fHLAfN68ly5W8MxtIUQohsByn-xbmohmpO8ZceCd7WvySrQG2XXsgv-2eqFpSups9zOxkEDiy1p9xIgkZsKATzjx5fYybef3gA7ow6r6B9bpDhTcEWLdbeeogoXo6L6rEeYPn3y2-_'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      'Unlock your personalized skincare journey',
                      style: AppTheme.heading2.copyWith(fontSize: 24),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    childAspectRatio: 1.5,
                    children: const [
                      _FeatureTile(title: 'Personalized Routine', description: 'Tailored to your skin\'s needs'),
                      _FeatureTile(title: 'Unlimited Scans', description: 'Track your progress over time'),
                      _FeatureTile(title: 'Exclusive Content', description: 'Access expert tips and tutorials'),
                      _FeatureTile(title: 'Priority Support', description: 'Get faster responses to your queries'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildUpgradeButton(),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            // TODO: Initiate Paddle payment flow here.
            // This would typically involve calling a method from a payment service
            // that interacts with the native Paddle SDK.
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryLight,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          ),
          child: Text('Upgrade Now', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String title;
  final String description;
  const _FeatureTile({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTheme.subtitle.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Text(description, style: AppTheme.bodyText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
