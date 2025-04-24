import 'package:flutter/material.dart';
//import 'package:badges/badges.dart' as badges;
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/routes/app_routes.dart';
import 'package:meditim_assistance/widgets/custom_nav_bar.dart';
import 'package:meditim_assistance/screens/page_Confirmed_Appointments.dart';
import 'package:meditim_assistance/screens/page_setting_assistant.dart';
//import 'package:meditim_assistance/screens/page_Notification_assistant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final int _notificationCount = 3;

  final List<Widget> _pages = [
    _MainContent(),
    const ConfirmedAppointmentsScreen(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        //notificationCount: _notificationCount,
        onTabChanged: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTabletOrBigger = constraints.maxWidth >= 600;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Welcome, Assistant",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            color: AppColors.primary),
                        onPressed: () => Navigator.pushNamed(
                            context, AppRoutes.pageNotificationassistant),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        _buildResponsiveCard(
                          isTabletOrBigger,
                          constraints.maxWidth,
                          child: _AnimatedCard(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.addAppointment),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: 'icon_add',
                                        child: Icon(Icons.add_circle_outlined,
                                            color: AppColors.primary, size: 28),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Add Appointment',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Create a new appointment',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _buildResponsiveCard(
                          isTabletOrBigger,
                          constraints.maxWidth,
                          child: _AnimatedCard(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.showAppointment),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          color: AppColors.primary, size: 28),
                                      SizedBox(width: 12),
                                      Text(
                                        'Show Appointment',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Browse scheduled appointments',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _buildResponsiveCard(
                          isTabletOrBigger,
                          constraints.maxWidth,
                          child: _AnimatedCard(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.todayAppointments),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.event_available_outlined,
                                          color: AppColors.primary, size: 28),
                                      SizedBox(width: 12),
                                      Text(
                                        "Today's Appointments",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Check today's schedule",
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _buildResponsiveCard(
                          isTabletOrBigger,
                          constraints.maxWidth,
                          child: _AnimatedCard(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.pageArchiv,
                              arguments: {
                                'type': 'archived',
                                'patient': 'John Doe',
                                'date': '2025-04-12',
                                'status': 'Completed',
                              },
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.archive_outlined,
                                          color: AppColors.primary, size: 28),
                                      SizedBox(width: 12),
                                      Text(
                                        'Archive',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'View Archived Appointments',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveCard(bool isTablet, double maxWidth,
      {required Widget child}) {
    return SizedBox(
      width: isTablet ? (maxWidth / 2) - 32 : double.infinity,
      child: child,
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const _AnimatedCard({required this.onTap, required this.child});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.97),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
