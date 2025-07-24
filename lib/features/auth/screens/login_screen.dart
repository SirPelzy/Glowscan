import 'package:flutter/material.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 218,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    // Replace with your actual image asset
                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBY__IHZWi8QIWoM6bZZvDZxVINS_6FUPpBPfYGOjM7h9hg3EfolOXzOyLLYuvbHL2yuLAx-u76AcAMLn3uNwzX8K0zzUusUjhu4wwPnngjHK3HDcRHOQkr51R0lNkOnSN-Wltc6wTmYRdlMf-vM7015OAy1ttukV8Vh-IwM2HwVO85A47tLCxvjG71YGFwThYq5dsXVJ1BYdVwm2fN4OjpQaIokSqykWXR0fCZXhZ0nBsqU0yZFZ3sufoCcPsvyL2dclFUjhNlXfy8'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Welcome to GlowScan', style: AppTheme.heading1, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Analyze your skin and get a personalized skincare routine.',
                  style: AppTheme.bodyText.copyWith(color: AppTheme.textPrimary),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildSocialButton('Continue with Google', () {
                      // TODO: Implement Google Sign-In
                    }),
                    const SizedBox(height: 12),
                    _buildSocialButton('Continue with Facebook', () {
                      // TODO: Implement Facebook Sign-In
                    }),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to Email Sign-Up screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          'Sign up with Email',
                          style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to actual email/password login form
                },
                child: Text(
                  'Already have an account? Log in',
                  style: AppTheme.bodyText.copyWith(fontSize: 14, color: AppTheme.textSecondary, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppTheme.surface,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
