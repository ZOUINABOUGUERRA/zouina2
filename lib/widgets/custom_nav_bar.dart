import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.secondaryColor,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textColor.withOpacity(0.5),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 28,
        items: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
            isActive: currentIndex == 0,
          ),
          _buildNavItem(
            icon: Icons.event_available_outlined,
            activeIcon: Icons.event_available,
            label: 'Confirmed',
            isActive: currentIndex == 2,
          ),
          _buildNavItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            label: 'Settings',
            isActive: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive
              ? AppColors.primary
              : AppColors.textColor.withOpacity(0.5),
          key: ValueKey(isActive),
        ),
      ),
      label: label,
    );
  }
}
