import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
//import 'package:meditim_assistance/routes/app_routes.dart';

class ConfirmedAppointmentsScreen extends StatefulWidget {
  const ConfirmedAppointmentsScreen({super.key});

  @override
  _ConfirmedAppointmentsScreenState createState() =>
      _ConfirmedAppointmentsScreenState();
}

class _ConfirmedAppointmentsScreenState
    extends State<ConfirmedAppointmentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredAppointments = [];

  final List<Map<String, dynamic>> _allAppointments = [
    {
      'patientName': 'أحمد محمد',
      'date': '2023-10-20 09:00 AM',
      'avatar': 'assets/avatar3.png'
    },
    {
      'patientName': 'فاطمة علي',
      'date': '2023-10-21 11:30 AM',
      'avatar': 'assets/avatar4.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredAppointments = _allAppointments;
    _searchController.addListener(_filterAppointments);
  }

  void _filterAppointments() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAppointments = _allAppointments.where((appointment) {
        return appointment['patientName'].toLowerCase().contains(query);
      }).toList();
    });
  }

  InputDecoration _searchDecoration() {
    return InputDecoration(
      hintText: 'ابحث عن مريض...',
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: const Icon(Icons.search, color: AppColors.secondaryColor),
      filled: true,
      fillColor: AppColors.textColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'المواعيد المؤكدة',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: _searchDecoration(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredAppointments.isEmpty
                  ? const Center(
                      child: Text(
                        'لا توجد مواعيد',
                        style: TextStyle(color: AppColors.textColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = _filteredAppointments[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(appointment['avatar']),
                              radius: 25,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.2),
                            ),
                            title: Text(
                              appointment['patientName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                            ),
                            subtitle: Text(
                              appointment['date'],
                              style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 13,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red[700]),
                              onPressed: () =>
                                  _showCancelDialog(context, appointment),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(
      BuildContext context, Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إلغاء الموعد',
            style: TextStyle(color: AppColors.primary)),
        content: Text('هل تريد حقاً إلغاء موعد ${appointment['patientName']}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تراجع',
                style: TextStyle(color: AppColors.textColor)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _allAppointments.remove(appointment);
                _filteredAppointments.remove(appointment);
              });
              Navigator.pop(context);
            },
            child: Text('تأكيد', style: TextStyle(color: Colors.red[700])),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
