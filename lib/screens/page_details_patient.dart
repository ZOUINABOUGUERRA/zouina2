import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class PageDetailsPatient extends StatelessWidget {
  const PageDetailsPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Map<String, String>) {
      return Scaffold(
        appBar: AppBar(title: const Text('تفاصيل الموعد')),
        body: const Center(child: Text('لا توجد بيانات متاحة')),
      );
    }

    final Map<String, String> appointment = args;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text(
            'تفاصيل الموعد',
            style: TextStyle(color: AppColors.whiteColor),
          ),
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/avatar1.png'),
                ),
                const SizedBox(height: 30),
                _buildInfoCard("اسم المريض", appointment['name']!),
                _buildInfoCard("تاريخ الموعد", appointment['date']!),
                _buildInfoCard("الوقت", appointment['time']!),
                _buildInfoCard("رقم الطلب", "#${appointment['order']}"),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.phone, color: Colors.white),
                  label: const Text(
                    "الاتصال بالمريض",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
