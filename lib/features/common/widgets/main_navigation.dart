import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
import 'package:glowscan_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:glowscan_app/features/scan/screens/image_capture_screen.dart';
// Import other main screens as you create them
// import 'package:glowscan_app/features/routine/screens/routine_screen.dart';
// import 'package:glowscan_app/features/progress/screens/progress_tracker_screen.dart';
// import 'package:glowscan_app/features/settings/screens/settings_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    // The Scan screen is usually presented modally, so we handle it in onTap.
    Text('Scan Placeholder'), 
    Text('Routine Screen'), // Replace with RoutineScreen()
    Text('Progress Screen'), // Replace with ProgressTrackerScreen()
    Text('Settings Screen'), // Replace with SettingsScreen()
  ];

  void _onItemTapped(int index) {
    if (index == 1) { // The "Scan" button index
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ImageCaptureScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildNavItem('Home', 'assets/images/house.svg', 0),
          _buildNavItem('Scan', 'assets/images/camera.svg', 1),
          _buildNavItem('Routine', 'assets/images/list-bullets.svg', 2),
          _buildNavItem('Progress', 'assets/images/chart-line.svg', 3),
          _buildNavItem('Settings', 'assets/images/gear.svg', 4),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.textPrimary,
        unselectedItemColor: AppTheme.textSecondary,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, String iconPath, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            _selectedIndex == index ? AppTheme.textPrimary : AppTheme.textSecondary,
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }
}
