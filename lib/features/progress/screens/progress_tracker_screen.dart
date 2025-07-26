import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart'; // Make sure fl_chart is in pubspec.yaml

class ProgressTrackerScreen extends StatefulWidget {
  const ProgressTrackerScreen({super.key});

  @override
  State<ProgressTrackerScreen> createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  double _sliderValue = 0.5;

  // Mock data - this would be fetched from your backend
  final beforeImageUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuB9GuxS301-O5f1tL6UJ53F94bkYNmDNTuXwhCWHrkJXDWdDzNATR1wTPUjFFPeqFGvjp8kEAAqgwyHvL4GLUmTa5MirwWAMKurkAu3qhEAVFPpfr04iENoDAyKV-V5M_g8zo96jXu9vlVG25DivSquA4AM-pVuLClYe7ArOJVY_zCR-eOd4X0H2QY4PdT4dR92vlCCgGlez9HEXzPAiWKZpwV5nqMkmSiA8ODKF9hJU6Vd00cWtTvI7_3xsn9xq9JDbzoI4G2OC_TK';
  final afterImageUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBKO0pCTeaMOM57q7lAiinZScpQCtauW7I6FgcZSxt0J9-NEmQXoyfisjHnLLFkxG1mV2U9AhodlvzbRIHsraF_MJ5Ml3vGP4GdgHlrLxLnvEivPxQ_C8jBK1X6iM2VUXS6YJWSUewkV9h_8-gJd68dXqO0C12BCYHcfw1bM6KuKk6095xloMTMJCbw_wXnFTisOu7Kc665rZEPo-5in6JOvWtJ9tGu19i8zfMZoGvNnzB3ECejNm5DpjEqEX0ZBEMRlAEgqpLZCIYg';
  final List<FlSpot> _chartData = const [
      FlSpot(0, 3), FlSpot(1, 1), FlSpot(2, 4), FlSpot(3, 2),
      FlSpot(4, 5), FlSpot(5, 3.5), FlSpot(6, 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Progress', style: AppTheme.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Before & After'),
            _buildBeforeAfterWidget(),
            _buildSectionHeader('Skin Score'),
            _buildSkinScoreChart(),
            _buildSectionHeader('Scan History'),
            _buildScanHistoryList(),
          ],
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

  Widget _buildBeforeAfterWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 400, // Adjust height as needed
            child: Stack(
              children: [
                Image.network(beforeImageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: _sliderValue,
                    child: Image.network(afterImageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                  ),
                ),
              ],
            ),
          ),
          Slider(
            value: _sliderValue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
            activeColor: AppTheme.textPrimary,
            inactiveColor: AppTheme.border,
          ),
        ],
      ),
    );
  }

  Widget _buildSkinScoreChart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Skin Score Over Time', style: AppTheme.bodyText),
          const Text('85', style: AppTheme.heading1),
          Row(
            children: [
              Text('Last 3 Months', style: AppTheme.subtitle.copyWith(fontSize: 14)),
              const SizedBox(width: 8),
              const Text('+5%', style: TextStyle(color: Color(0xFF078859), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _chartData,
                    isCurved: true,
                    color: AppTheme.textSecondary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [AppTheme.surface.withOpacity(0.8), AppTheme.surface.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanHistoryList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _ScanHistoryTile(date: '2024-03-15'),
        _ScanHistoryTile(date: '2024-02-15'),
        _ScanHistoryTile(date: '2024-01-15'),
      ],
    );
  }
}

class _ScanHistoryTile extends StatelessWidget {
  final String date;
  const _ScanHistoryTile({required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: const Text('Scan Result', style: AppTheme.bodyText),
      subtitle: Text(date, style: AppTheme.subtitle.copyWith(fontSize: 14)),
      trailing: SvgPicture.asset('assets/images/arrow-right.svg'),
      onTap: () {
        // TODO: Navigate to the detailed result page for this scan
      },
    );
  }
}
