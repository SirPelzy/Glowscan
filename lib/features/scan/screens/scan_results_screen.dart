import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
// Import your other screens for navigation
// import 'package:glowscan_app/features/routine/screens/routine_screen.dart';

// Placeholder model for the analysis result data from the backend
class AnalysisResult {
  final String imageUrl;
  final Map<String, int> scores;

  AnalysisResult({required this.imageUrl, required this.scores});
}

class ScanResultsScreen extends StatelessWidget {
  const ScanResultsScreen({super.key});

  // In a real app, you would pass the actual result object to this screen
  final AnalysisResult mockResult = const AnalysisResult(
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDTAajATdLuLH6Yo7nl9bjNmLrEqdyHdqMAdEqGQd_v0o0eXBnOtDgF6qsHTkgIt7zvy-Xfo_c-KFVgyP9V9rVaTv4InXiIsJlRJ8Z1GBWRdvj1p9ltgCZYy5ZdXuSvaxlxZ8iJBGuncTc3VcFvDT8ECDzi38KEBqiCMlwapDR2xVTYSTtCaeB67ORaaJ1qm1MlepT4wjdTIsJAK1OgKqUHEQ4nOxZmcu5_OEhNdOiNGYx35e3vkipgv6CpLh3ITSnYm9wcxqyY6rvI',
    scores: {
      'Hydration': 85,
      'Wrinkles': 70,
      'Pores': 60,
      'Redness': 90,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Skin Scan Results', style: AppTheme.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(mockResult.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Text('Skin Health Scores', style: AppTheme.heading2),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mockResult.scores.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                String key = mockResult.scores.keys.elementAt(index);
                int value = mockResult.scores.values.elementAt(index);
                return _ScoreCard(title: key, score: value);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text('Recommended Next Steps', style: AppTheme.heading2),
            ),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Navigate to the RoutineScreen
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RoutineScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE3E79), // Slightly different primary color from design
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
              child: const Text('View Personalized Routine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {
                // This would typically save the result and then pop the screen
                // The result is already saved on the backend via the /api/progress/track endpoint
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Results Saved!')),
                );
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.surface,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
              child: const Text('Save Results', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final int score;

  const _ScoreCard({required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTheme.bodyText),
          const SizedBox(height: 4),
          Text(
            score.toString(),
            style: AppTheme.heading1.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
