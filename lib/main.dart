import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
import 'package:glowscan_app/features/auth/screens/onboarding_screen.dart';
import 'package:glowscan_app/features/common/widgets/main_screen.dart';
// You might need a service to check for an existing auth token
// import 'package:glowscan_app/core/services/secure_storage_service.dart';

// --- Authentication State Provider ---
// This simple provider will determine if a user is logged in.
// In a real app, you'd check for a token in secure storage.
final authStateProvider = StateProvider<bool>((ref) {
  // TODO: Replace this with actual logic to check for a stored auth token.
  // For example:
  // final token = await ref.read(secureStorageServiceProvider).getToken();
  // return token != null;
  return false; // Default to not logged in
});


void main() {
  // It's good practice to wrap the app in a ProviderScope for Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the authentication state
    final bool isLoggedIn = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'GlowScan',
      // Remove the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,
      // Apply the custom theme we created
      theme: AppTheme.themeData,
      // The home property determines the first screen to show.
      // If the user is logged in, show the MainScreen (with the nav bar).
      // Otherwise, show the OnboardingScreen.
      home: isLoggedIn ? const MainScreen() : const OnboardingScreen(),
    );
  }
}
