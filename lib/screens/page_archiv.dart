import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';

  final List<Map<String, String>> _appointments = [
    {'patient': 'John Doe', 'date': '2025-04-12', 'status': 'Completed'},
    {'patient': 'Sarah Smith', 'date': '2025-04-10', 'status': 'Cancelled'},
    {'patient': 'Ali Karim', 'date': '2025-03-28', 'status': 'Completed'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAppointments = _appointments.where((appointment) {
      final searchText = _searchController.text.toLowerCase();
      final matchesName =
          appointment['patient']!.toLowerCase().contains(searchText);
      final matchesStatus =
          _selectedStatus == 'All' || appointment['status'] == _selectedStatus;
      return matchesName && matchesStatus;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Archived Appointments',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by patient name',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter by status:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedStatus,
                  dropdownColor: AppColors.whiteColor,
                  items: ['All', 'Completed', 'Cancelled']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status,
                                style: const TextStyle(
                                    color: AppColors.textColor)),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedStatus = value!),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredAppointments.isEmpty
                  ? const Center(
                      child: Text(
                        'No matching appointments found.',
                        style: TextStyle(color: AppColors.textColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredAppointments.length,
                      itemBuilder: (context, index) {
                        final appt = filteredAppointments[index];
                        Color statusColor;
                        switch (appt['status']) {
                          case 'Completed':
                            statusColor = AppColors.confirmedColor;
                            break;
                          case 'Cancelled':
                            statusColor = AppColors.errorColor;
                            break;
                          default:
                            statusColor = AppColors.textColor;
                        }

                        return Card(
                          color: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: ListTile(
                            leading: const Icon(Icons.person_outline,
                                color: AppColors.primary),
                            title: Text(
                              appt['patient'] ?? '',
                              style: const TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Date: ${appt['date']}',
                              style:
                                  const TextStyle(color: AppColors.textColor),
                            ),
                            trailing: Text(
                              appt['status'] ?? '',
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
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
}
