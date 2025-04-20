import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/screens/modify_information_of_cilinc.dart';
import 'package:meditim_assistance/screens/page_assisatent_profile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: isLargeScreen
            ? null
            : AppBar(
                title: const Text(
                  'الإعدادات',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                centerTitle: true,
                backgroundColor: AppColors.primary,
                iconTheme: const IconThemeData(color: AppColors.whiteColor),
              ),
        body: SafeArea(
          child: Row(
            children: [
              if (isLargeScreen)
                const SizedBox(
                  width: 200,
                  child: Drawer(
                    child: Center(child: Text("الإعدادات")),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 16,
                    vertical: 20,
                  ),
                  child: _buildSettingsList(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return ListView(
      children: [
        _buildSectionHeader('عام'),
        _buildSettingItem(
          icon: Icons.business,
          title: 'تعديل معلومات العيادة',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ClinicInfoPage()),
            );
          },
        ),
        _buildSettingItem(
          icon: Icons.person,
          title: 'ملف المساعد',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AssistantProfilePage()),
            );
          },
        ),
        _buildSettingItem(
          icon: Icons.language,
          title: 'تغيير اللغة',
          onTap: () {
            // نضيف وظيفة تغيير اللغة لاحقًا
          },
        ),
        const Divider(height: 40),
        _buildSectionHeader('الحساب'),
        _buildSettingItem(
          icon: Icons.logout,
          title: 'تسجيل الخروج',
          iconColor: AppColors.errorColor,
          textColor: AppColors.errorColor,
          onTap: () {
            // نضيف تسجيل الخروج لاحقًا
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppColors.primary,
    Color textColor = AppColors.textColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: TextStyle(fontSize: 16, color: textColor)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        onTap: onTap,
      ),
    );
  }
}
