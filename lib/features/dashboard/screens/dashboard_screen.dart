import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
// Note: You will create this navigation bar widget next.
// import 'package:glowscan_app/features/common/widgets/main_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // In a real app, these would come from a state provider (like Riverpod)
  // after fetching from the /api/users/me and /api/progress/trends endpoints.
  String userName = "Sophia";
  String userProfileImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuAqORPd4RsLlxPNR3xO70DbLp5DtTt0KDj29N5hBKsPtoHoAtgcHZCohjLMM9kvjTBkLh2UhJsRGesbqJs680XPo9dtuAKolpt3a7BxLgqdbJN07sBGa6tG6NNX6kWR_EFteRdyhUgAE8OjwZSzmECGSB4yEscAfcDVgIm7ahTGPwyNacdircX7t0S9zLgB_KLKnkTs3fZvx3V-73jB6A_49pIGaImbBcjRZ4E0vd1mIi5CPMQJAlbimHEpPuWuMEV9lElTFFmigJo9";
  String skinScoreImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuBV3LpP0qL2a1dBsmYQKCOT7j3aXP0NgStsylsT0NOo9RO49gImfU4C9W5MAJ5k082BbtF2ctRjsXGUUjGEoLjhp9NkOViImRnMyy03PVqq9082Xb6uLmjxvQI2kiiSzEP1qeD4HACaxNh8IjgklXtP8_Ah9Bsap0rPAEqPfFjf93rbqSXIujj4qwabQUitGBPqSflsePRSgcP7dGn8_hviTHHOwK_YRoFG69VS7_ueGGI8JV40Dm9IsOkuNhBuH05nT_FjTwO2ipZD";
  String skinScore = "85/100";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The bottomNavigationBar would be defined here.
      // bottomNavigationBar: MainNavigationBar(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              _buildProfileHeader(),
              _buildAiScoreCard(),
              _buildScanButton(),
              _buildSectionHeader("Last Scan Summary"),
              _buildScanSummaryGrid(),
              _buildSectionHeader("Quick Links"),
              _buildQuickLinks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(userProfileImageUrl),
          ),
          IconButton(
            icon: SvgPicture.asset('assets/images/gear.svg', colorFilter: const ColorFilter.mode(AppTheme.textPrimary, BlendMode.srcIn)),
            onPressed: () {
              // TODO: Navigate to Settings
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(userProfileImageUrl)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: AppTheme.heading2),
              const Text('Welcome back', style: AppTheme.subtitle),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildAiScoreCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                image: DecorationImage(image: NetworkImage(skinScoreImageUrl), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('AI Skin Score', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(skinScore, style: AppTheme.subtitle),
                  const SizedBox(height: 4),
                  const Text(
                    "Your skin score is calculated based on your latest scan results and provides insights into your skin's overall health.",
                    style: AppTheme.subtitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScanButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to Scan Screen
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: Text('Scan My Skin', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
     return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Text(title, style: AppTheme.heading2),
    );
  }
  
  Widget _buildScanSummaryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 3.5,
        children: const [
          _ScanMetric(metric: 'Hydration', value: '8/10'),
          _ScanMetric(metric: 'Texture', value: '7/10'),
          _ScanMetric(metric: 'Redness', value: '6/10'),
          _ScanMetric(metric: 'Pores', value: '7/10'),
          _ScanMetric(metric: 'Wrinkles', value: '5/10'),
          _ScanMetric(metric: 'Acne', value: '9/10'),
        ],
      ),
    );
  }

  Widget _buildQuickLinks() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _QuickLinkCard(title: 'Daily Routine', iconPath: 'assets/images/sun.svg', onTap: () {}),
          const SizedBox(height: 12),
          _QuickLinkCard(title: 'Progress Tracker', iconPath: 'assets/images/chart-line.svg', onTap: () {}),
           const SizedBox(height: 12),
          _QuickLinkCard(title: 'Skincare Tips', iconPath: 'assets/images/lightbulb.svg', onTap: () {}),
        ],
      )
    );
  }
}

class _ScanMetric extends StatelessWidget {
  final String metric;
  final String value;
  const _ScanMetric({required this.metric, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppTheme.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(metric, style: AppTheme.subtitle.copyWith(fontSize: 14)),
          Text(value, style: AppTheme.bodyText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _QuickLinkCard({required this.title, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.border),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, width: 24, height: 24, colorFilter: const ColorFilter.mode(AppTheme.textPrimary, BlendMode.srcIn)),
            const SizedBox(width: 12),
            Text(title, style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
