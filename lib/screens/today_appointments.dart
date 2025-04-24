import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/routes/app_routes.dart';

class TodayAppointmentsScreen extends StatefulWidget {
  const TodayAppointmentsScreen({super.key});

  @override
  _TodayAppointmentsScreenState createState() =>
      _TodayAppointmentsScreenState();
}

class _TodayAppointmentsScreenState extends State<TodayAppointmentsScreen> {
  // Sample data - can be replaced with real data
  List<Map<String, String>> appointments = [
    {
      'order': '1',
      'name': 'Amel Bensalem',
      'date': 'Monday 23-03-2025',
      'time': '11:00 AM',
      'phone': '0554 32 45 67',
      'address': 'Rue 20 Août, Algiers',
      'notes': 'Suffers from persistent headaches.',
      'status': 'Under follow-up',
    },
    {
      'order': '2',
      'name': 'Yacine Touati',
      'date': 'Monday 23-03-2025',
      'time': '02:30 PM',
      'phone': '0661 98 12 33',
      'address': 'Lotissement 7, Oran',
      'notes': 'Chronic diabetic patient.',
      'status': 'Needs tests',
    },
  ];

  @override
  void initState() {
    super.initState();
    appointments.sort(
        (a, b) => int.parse(a['order']!).compareTo(int.parse(b['order']!)));
  }

  void _deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  void _archiveAppointment(Map<String, String> appointment) {
    Navigator.pushNamed(
      context,
      AppRoutes.pageArchiv,
      arguments: appointment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Today\'s Confirmed Appointments',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: Text(
                'Appointments List:',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: appointments.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return _buildAppointmentCard(appointment, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, String> appointment, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.2),
          child: Text(
            '#${appointment['order']}',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.pageDetailsPatient,
              arguments: {
                'name': appointment['name'],
                'date': appointment['date'],
                'time': appointment['time'],
                'order': appointment['order'],
              },
            );
          },
          child: Text(
            appointment['name']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              appointment['date']!,
              style: TextStyle(color: AppColors.textColor.withOpacity(0.7)),
            ),
            Text(
              'Time: ${appointment['time']}',
              style: TextStyle(color: AppColors.textColor.withOpacity(0.7)),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.medical_services, color: AppColors.primary),
              onPressed: () => _archiveAppointment(appointment),
              tooltip: 'Checked',
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[700]),
              onPressed: () => _deleteAppointment(index),
              tooltip: 'Delete appointment',
            ),
          ],
        ),
      ),
    );
  }
}
