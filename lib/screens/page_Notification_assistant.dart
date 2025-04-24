import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Notifications'),
        centerTitle: true,
        leading: const BackButton(color: AppColors.whiteColor),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_active_outlined,
                size: 80, color: AppColors.primary),
            SizedBox(height: 10),
            Text(
              'Send notifications to patients easily',
              style: TextStyle(fontSize: 18, color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
