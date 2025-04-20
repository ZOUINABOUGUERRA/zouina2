import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/routes/app_routes.dart';
import 'package:meditim_assistance/widgets/custom_nav_bar.dart';
import 'package:meditim_assistance/screens/page_Confirmed_Appointments.dart';
import 'package:meditim_assistance/screens/page_add_monthly_appointements.dart';
import 'package:meditim_assistance/screens/page_add_weekly_app.dart';
import 'package:meditim_assistance/screens/page_setting_assistant.dart';
import 'package:meditim_assistance/screens/show_monthly_oppoientment.dart';
import 'package:meditim_assistance/screens/show_weekly_oppointments.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            tooltip: 'الإشعارات',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.pageNotificationassistant);
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
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
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildResponsiveCard(
                        isTabletOrBigger,
                        constraints.maxWidth,
                        child: _buildAppointmentSection(
                          title: 'Add Appointment',
                          options: ['Weekly', 'Monthly'],
                          icon: Icons.add_circle_outlined,
                          onTap: (option) => _navigate(
                              context, AppRoutes.addAppointment, option),
                        ),
                      ),
                      _buildResponsiveCard(
                        isTabletOrBigger,
                        constraints.maxWidth,
                        child: _buildAppointmentSection(
                          title: 'Show Appointment',
                          options: ['Weekly', 'Monthly'],
                          icon: Icons.calendar_today_outlined,
                          onTap: (option) => _navigatee(
                              context, AppRoutes.showAppointment, option),
                        ),
                      ),
                      _buildResponsiveCard(
                        isTabletOrBigger,
                        constraints.maxWidth,
                        child: _buildTodayAppointmentsSection(context),
                      ),
                      _buildResponsiveCard(
                        isTabletOrBigger,
                        constraints.maxWidth,
                        child: _buildArchiveSection(context),
                      ),
                    ],
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

  Widget _buildAppointmentSection({
    required String title,
    required List<String> options,
    required IconData icon,
    required Function(String?) onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(null),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: AppColors.primary, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: options.map((option) {
                  return ChoiceChip(
                    label: Text(
                      option,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                    selected: false,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.primary.withOpacity(0.6),
                    onSelected: (_) => onTap(option),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayAppointmentsSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(context, AppRoutes.todayAppointments),
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
                    'Today\'s Appointments',
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
                'Check Today\'s Schedule',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArchiveSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
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
    );
  }

  void _navigate(BuildContext context, String route, String? option) {
    if (route == AppRoutes.addAppointment && option == 'Monthly') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddMonthlyAppointmentPage()),
      );
    } else if (route == AppRoutes.addAppointment && option == 'Weekly') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddweeklyAppointmentPage()),
      );
    } else {
      Navigator.pushNamed(
        context,
        route,
        arguments: {'type': option ?? 'regular'},
      );
    }
  }

  void _navigatee(BuildContext context, String route, String? option) {
    if (route == AppRoutes.showAppointment && option == 'Monthly') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MonthlyAppointmentsPage()),
      );
    } else if (route == AppRoutes.showAppointment && option == 'Weekly') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WeeklyAppointmentsPage()),
      );
    } else {
      Navigator.pushNamed(
        context,
        route,
        arguments: {'type': option ?? 'regular'},
      );
    }
  }
}
