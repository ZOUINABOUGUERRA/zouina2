import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class Appointment {
  final String day;
  final String start;
  final String end;

  Appointment({required this.day, required this.start, required this.end});
}

class WeeklyAppointmentsPage extends StatefulWidget {
  const WeeklyAppointmentsPage({super.key});

  @override
  State<WeeklyAppointmentsPage> createState() => _WeeklyAppointmentsPageState();
}

class _WeeklyAppointmentsPageState extends State<WeeklyAppointmentsPage> {
  List<Appointment> appointments = [
    Appointment(day: 'الثلاثاء', start: '8', end: '16'),
    Appointment(day: 'الأربعاء', start: '8', end: '16'),
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
        title: const Text('حذف الموعد'),
        content: const Text('هل أنت متأكد من حذف هذا الموعد؟'),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
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
        title: const Text('حذف جميع المواعيد'),
        content: const Text('هل أنت متأكد من حذف جميع المواعيد؟'),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
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

  Widget _buildAppointmentCard(Appointment appointment, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.secondaryColor,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اليوم: ${appointment.day}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'من الساعة ${appointment.start}:00 إلى ${appointment.end}:00',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('تعديل'),
                  onPressed: () {
                    // تعديل الموعد
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('حذف'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () => _confirmDeleteAppointment(context, index),
                ),
              ],
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
        title: const Text('المواعيد الأسبوعية'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'عرض المواعيد الأسبوعية',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: appointments.isEmpty
                  ? const Center(child: Text('لا توجد مواعيد حالياً.'))
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) =>
                          _buildAppointmentCard(appointments[index], index),
                    ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('حذف الكل',
                  style: TextStyle(color: AppColors.whiteColor)),
              onPressed: appointments.isEmpty
                  ? null
                  : () => _confirmDeleteAll(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
