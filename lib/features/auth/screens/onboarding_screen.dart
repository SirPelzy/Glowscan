import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart'; // A great package for page indicators
import 'package:glowscan_app/core/theme/app_theme.dart';
import 'package.glowscan_app/features/auth/screens/login_screen.dart'; 

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController _controller = CarouselController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingPages = [
      // Screen 1 (from previous request)
      _OnboardingPage(
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBSXBIZXcr_nMsVryCM7wb17wx_4tKKFg0C_8mR-CNFdxMSK1vq6Rn11pmnCR9RVGBc0ogE-dAA7s4lYnIXJ6fvfEYTXrz6fBYHAVbUxVBqHqp2-hJTkVue0k2AnhreyNW71XCifoUJ1Q7zjh3lOZD8sDreXhvCDXkAczehrLJWHktPL957GDCD4OUk2NU1Wl1aHfmqG0KkH_OJDYJmquKRVW3X6ZlVsqvrJV_CBj-RfTaebTjEJlYUyRKkA4G1Tc2gwcNeO_huMYJ_', 
        title: 'Welcome to GlowScan',
        description: "Discover your skin's unique needs and unlock a personalized skincare journey.",
        buttonText: 'Get Started',
        onPressed: () => _controller.nextPage(),
        isFinalPage: false,
      ),
      // Screen 2 (your new request)
      _OnboardingPage(
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC0XoZUkkEl7TefWhKwe-YRY3GAPOkE5ix841e89s6wry1w2L6Fy0M9yKCzrM0VOKyYppDa5NmJBO_3MwA2WBqtfTogwMC7n0xVedHjpHmpXvZtGf80mwesN-yzKHG5SL1-utyeNezvW6dVI2x0hX9FZD53vmgb3uO5ZL3oP9T-_S8uagZxpEvOceCugjYWBjpus6t6tUNk7usvfbMFdgQay5sTyWQLo5UuQ6Zt7raMqwDGmBTbJGr6d_CWB_-z91DAcEENJftb5T0U',
        title: "Unlock Your Skin's Potential",
        description: 'GlowScan uses AI to analyze your skin and create a personalized skincare routine tailored to your unique needs.',
        buttonText: 'Next',
        onPressed: () => _controller.nextPage(),
        isFinalPage: false,
      ),
      // Screen 3 - Final screen with Login/Signup (from previous request)
      _OnboardingPage(
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDXTGBH938ETCdmXlxwhGBurileD-GQvuv7dTYPZOqRhdVmDC8VhjLJYDqmkDopL5lVipaTUsApWeVTPBZrtGMFr_SAvmpCrJCQh3DrKeQNji1_GtnH-Ph1_Ofc7peo4ga5DbBm6kj8MN8exLjAPggDkXCBpwE74fee-fif9q1EcTrtuBhvlfiw3PrYDjbQ8TadnhznBFH6flT_MD9VR7SWTiZCwxJMbkyNk-3SPFK7zABgUC1_w6sfbgLp7ohYirkJfBEIKYNvNp7A',
        title: "Unlock Your Skin's Potential",
        description: 'Get personalized skincare recommendations tailored to your unique needs.',
        isFinalPage: true,
        onSignUp: () {
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
        },
        onLogIn: () {
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
        },
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            items: onboardingPages,
            carouselController: _controller,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          if (_currentPage != onboardingPages.length - 1)
            Positioned(
              bottom: 100, // Adjust this value to position the dots
              child: DotsIndicator(
                dotsCount: onboardingPages.length,
                position: _currentPage,
                decorator: DotsDecorator(
                  color: AppTheme.border, // Inactive color
                  activeColor: AppTheme.textPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// The _OnboardingPage sub-widget remains the same as before, but now handles the indicator logic
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
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
        // This ensures the buttons are always at the bottom
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
          child: isFinalPage ? _buildFinalButtons() : _buildNextButton(),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text(buttonText ?? '', style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildFinalButtons() {
    return Column(
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
    );
  }
}
