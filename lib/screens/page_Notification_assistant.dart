import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  void _showSendNotificationDialog(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'إرسال إشعار عام',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: messageController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'اكتب محتوى الإشعار هنا...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.confirmedColor,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('إرسال'),
            onPressed: () {
              final message = messageController.text.trim();
              if (message.isNotEmpty) {
                // TODO: إرسال الإشعار عبر Firebase لاحقًا
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ تم إرسال الإشعار')),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('الإشعارات'),
        centerTitle: true,
        leading: const BackButton(color: AppColors.whiteColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert_rounded, color: Colors.white),
            tooltip: 'إرسال إشعار عام',
            onPressed: () => _showSendNotificationDialog(context),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_active_outlined,
                size: 80, color: AppColors.primary),
            SizedBox(height: 10),
            Text(
              'أرسل إشعارات للمرضى بسهولة',
              style: TextStyle(fontSize: 18, color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
