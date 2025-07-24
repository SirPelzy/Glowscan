import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';

// You would navigate to the actual Login/SignUp screens from here.
// For now, they are just placeholders.
import 'package:glowscan_app/features/auth/screens/login_screen.dart'; 


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingPages = [
      _OnboardingPage(
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBSXBIZXcr_nMsVryCM7wb17wx_4tKKFg0C_8mR-CNFdxMSK1vq6Rn11pmnCR9RVGBc0ogE-dAA7s4lYnIXJ6fvfEYTXrz6fBYHAVbUxVBqHqp2-hJTkVue0k2AnhreyNW71XCifoUJ1Q7zjh3lOZD8sDreXhvCDXkAczehrLJWHktPL957GDCD4OUk2NU1Wl1aHfmqG0KkH_OJDYJmquKRVW3X6ZlVsqvrJV_CBj-RfTaebTjEJlYUyRKkA4G1Tc2gwcNeO_huMYJ_', // Replace with your asset
        title: 'Welcome to GlowScan',
        description: "Discover your skin's unique needs and unlock a personalized skincare journey.",
        buttonText: 'Get Started',
        onPressed: () {
          // This would navigate to the next slide
        },
      ),
      // Add other onboarding slides here if you have them
      _OnboardingPage(
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDXTGBH938ETCdmXlxwhGBurileD-GQvuv7dTYPZOqRhdVmDC8VhjLJYDqmkDopL5lVipaTUsApWeVTPBZrtGMFr_SAvmpCrJCQh3DrKeQNji1_GtnH-Ph1_Ofc7peo4ga5DbBm6kj8MN8exLjAPggDkXCBpwE74fee-fif9q1EcTrtuBhvlfiw3PrYDjbQ8TadnhznBFH6flT_MD9VR7SWTiZCwxJMbkyNk-3SPFK7zABgUC1_w6sfbgLp7ohYirkJfBEIKYNvNp7A', // Replace with your asset
        title: "Unlock Your Skin's Potential",
        description: 'Get personalized skincare recommendations tailored to your unique needs.',
        isFinalPage: true, // This will show the two buttons
        onSignUp: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
        },
        onLogIn: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
        },
      ),
    ];
    
    // We use CarouselSlider to make it swipeable.
    return Scaffold(
      body: CarouselSlider(
        items: onboardingPages,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          autoPlay: false,
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String? buttonText;
  final bool isFinalPage;
  final VoidCallback? onPressed;
  final VoidCallback? onSignUp;
  final VoidCallback? onLogIn;

  const _OnboardingPage({
    required this.imageUrl,
    required this.title,
    required this.description,
    this.buttonText,
    this.isFinalPage = false,
    this.onPressed,
    this.onSignUp,
    this.onLogIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400, // min-h-80 equivalent
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Text(title, style: AppTheme.heading1, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Text(description, style: AppTheme.bodyText, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isFinalPage)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: Text(buttonText ?? '', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onSignUp,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text('Sign Up', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onLogIn,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.surface, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text('Log In', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // For bottom spacing
      ],
    );
  }
}
