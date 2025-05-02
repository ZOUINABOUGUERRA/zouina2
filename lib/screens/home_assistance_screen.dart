import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/routes/app_routes.dart';
import 'package:meditim_assistance/widgets/custom_nav_bar.dart';
import 'package:meditim_assistance/screens/page_Confirmed_Appointments.dart';
import 'package:meditim_assistance/screens/page_setting_assistant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const _MainContent(),
    const ConfirmedAppointmentsScreen(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
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
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height -
        kToolbarHeight -
        mediaQuery.padding.top -
        kBottomNavigationBarHeight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTabletOrBigger = constraints.maxWidth >= 600;
        return SizedBox(
          height: availableHeight,
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildResponsiveCard(
                      isTabletOrBigger,
                      constraints.maxWidth,
                      delay: 0,
                      child: _AnimatedCard(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.addAppointment),
                        icon: Icons.add_circle_outlined,
                        title: 'Add Appointment',
                        subtitle: 'Create a new appointment',
                      ),
                    ),
                    _buildResponsiveCard(
                      isTabletOrBigger,
                      constraints.maxWidth,
                      delay: 100,
                      child: _AnimatedCard(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.showAppointment),
                        icon: Icons.calendar_today_outlined,
                        title: 'Show Appointment',
                        subtitle: 'Browse scheduled appointments',
                      ),
                    ),
                    _buildResponsiveCard(
                      isTabletOrBigger,
                      constraints.maxWidth,
                      delay: 200,
                      child: _AnimatedCard(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.todayAppointments),
                        icon: Icons.event_available_outlined,
                        title: "Today's Appointments",
                        subtitle: "Check today's schedule",
                      ),
                    ),
                    _buildResponsiveCard(
                      isTabletOrBigger,
                      constraints.maxWidth,
                      delay: 300,
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
                        icon: Icons.archive_outlined,
                        title: 'Archive',
                        subtitle: 'View Archived Appointments',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveCard(bool isTablet, double maxWidth,
      {required Widget child, required int delay}) {
    return SizedBox(
      width: isTablet ? (maxWidth / 2) - 32 : double.infinity,
      child: _CardWithAnimation(delay: delay, child: child),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String subtitle;

  const _AnimatedCard({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

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
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.icon, color: AppColors.primary, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardWithAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  const _CardWithAnimation({required this.child, required this.delay});

  @override
  State<_CardWithAnimation> createState() => _CardWithAnimationState();
}

class _CardWithAnimationState extends State<_CardWithAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _offset =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() => _controller.dispose();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}
