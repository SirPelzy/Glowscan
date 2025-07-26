import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Settings', style: AppTheme.heading2),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const _SettingsSectionHeader(title: 'Account'),
          _SettingsTile(
            isProfile: true,
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCkZK9U5r1V2nco2ftw8N1CCEI4ycET2yV_d0QwyE_iVRrGCCfmuYkR60KfYgq2MNAHrtDIgX6rR3j06YDQ_RtYNRn4m2PycW6gv_Lu-Mmr9bMizzZdDOEw3Szec9pE34IvM4X6hJdamRWbl9UYjVYdhQQXX-OXwwOj86_GME4M31IwxyShaZB8HibVDHT_JdQg5HDW2mhNMIWIXdyFSXkP9PP4HWcubo1kpIwgEUx7n8Uj5MITst6_Zv0USd1pVrJk3BQdhvdAo8Wr',
            title: 'Profile',
            subtitle: 'View and edit your profile',
            onTap: () { /* TODO: Navigate to Profile Screen */ },
          ),
          _SettingsTile(
            iconPath: 'assets/images/credit-card.svg',
            title: 'Subscription',
            subtitle: 'Manage your subscription',
            onTap: () { /* TODO: Navigate to Subscription Management */ },
          ),
          const _SettingsSectionHeader(title: 'Preferences'),
           _SettingsTile(
            iconPath: 'assets/images/bell.svg',
            title: 'Notifications',
            subtitle: 'Manage your notification settings',
            onTap: () { /* TODO: Navigate to Notifications Screen */ },
          ),
           _SettingsTile(
            iconPath: 'assets/images/shield.svg',
            title: 'Privacy',
            subtitle: 'Manage your privacy settings',
            onTap: () { /* TODO: Navigate to Privacy Screen */ },
          ),
          const _SettingsSectionHeader(title: 'Support'),
           _SettingsTile(
            iconPath: 'assets/images/question.svg',
            title: 'Help Center',
            subtitle: 'Contact customer support',
            onTap: () { /* TODO: Open help center link or mailto */ },
          ),
           _SettingsTile(
            iconPath: 'assets/images/info.svg',
            title: 'About',
            subtitle: 'Learn more about GlowScan',
            onTap: () { /* TODO: Navigate to About Screen */ },
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  final String title;
  const _SettingsSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: AppTheme.bodyText.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}


class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String? iconPath;
  final String? imageUrl;
  final bool isProfile;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconPath,
    this.imageUrl,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: isProfile
          ? CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl!))
          : Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: SvgPicture.asset(iconPath!, width: 24, height: 24)),
            ),
      title: Text(title, style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: AppTheme.subtitle.copyWith(fontSize: 14)),
      onTap: onTap,
    );
  }
}
