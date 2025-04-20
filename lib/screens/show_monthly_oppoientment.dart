import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

// نموذج Appointment الشهري
class MonthlyAppointment {
  final String date;
  final String start;
  final String end;

  MonthlyAppointment({
    required this.date,
    required this.start,
    required this.end,
  });
}

class MonthlyAppointmentsPage extends StatefulWidget {
  const MonthlyAppointmentsPage({super.key});

  @override
  State<MonthlyAppointmentsPage> createState() =>
      _MonthlyAppointmentsPageState();
}

class _MonthlyAppointmentsPageState extends State<MonthlyAppointmentsPage> {
  List<MonthlyAppointment> appointments = [
    MonthlyAppointment(date: '2025-04-20', start: '08:00', end: '16:00'),
    MonthlyAppointment(date: '2025-04-25', start: '09:00', end: '13:00'),
  ];

  void _deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  void _confirmDeleteAppointment(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إلغاء الموعد'),
        content: const Text('هل تريد فعلاً حذف هذا الموعد؟'),
        actions: [
          TextButton(
            child: const Text('تراجع'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              _deleteAppointment(index);
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف كل المواعيد'),
        content: const Text('هل تريد فعلاً حذف جميع المواعيد؟'),
        actions: [
          TextButton(
            child: const Text('تراجع'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('حذف الكل', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                appointments.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(MonthlyAppointment appointment, int index) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.calendar_month, color: AppColors.primary),
        title: Text(
          'التاريخ: ${appointment.date}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        subtitle: Text(
          'من ${appointment.start} إلى ${appointment.end}',
          style: const TextStyle(color: AppColors.textColor),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: AppColors.primary),
          onSelected: (value) {
            if (value == 'edit') {
              // تعديل الموعد
            } else if (value == 'delete') {
              _confirmDeleteAppointment(context, index);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('تعديل'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('مواعيد الشهر',
            style: TextStyle(color: AppColors.whiteColor)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'المواعيد المحجوزة لهذا الشهر:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: appointments.isEmpty
                  ? const Center(
                      child: Text(
                        'لا توجد مواعيد حالياً.',
                        style: TextStyle(color: AppColors.textColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return _buildAppointmentCard(
                            appointments[index], index);
                      },
                    ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: appointments.isEmpty
                  ? null
                  : () => _confirmDeleteAll(context),
              icon:
                  const Icon(Icons.delete_forever, color: AppColors.whiteColor),
              label: const Text('حذف الكل',
                  style: TextStyle(color: AppColors.whiteColor)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
