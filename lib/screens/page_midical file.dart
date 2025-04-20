import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart'; // غيّر المسار حسب مشروعك

class MedicalFilePage extends StatelessWidget {
  const MedicalFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'الملف الطبي',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfoSection(),
            const SizedBox(height: 30),
            _buildClinicInfoSection(),
            const SizedBox(height: 30),
            _buildPrescriptionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfoSection() {
    return const Card(
      elevation: 4,
      color: AppColors.secondaryColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zouina Bouguerra',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: AppColors.textColor),
                SizedBox(width: 8),
                Text(
                  'Visited the clinic on Monday 23-03-2025 at 11:00 AM',
                  style: TextStyle(color: AppColors.textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicInfoSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'HEALTH CHOICE CLINIC',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 15,
          children: [
            Chip(
              label: Text('Sustainability'),
              backgroundColor: AppColors.confirmedColor,
              labelStyle: TextStyle(color: AppColors.whiteColor),
            ),
            Chip(
              label: Text('Development'),
              backgroundColor: AppColors.primary,
              labelStyle: TextStyle(color: AppColors.whiteColor),
            ),
            Chip(
              label: Text('Technology'),
              backgroundColor:
                  Colors.orange, // إذا عندك لون معين ممكن نحطه هنا بعد
              labelStyle: TextStyle(color: AppColors.whiteColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.medical_services, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'Prescription',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildMedicineCard('Paracetamol 500mg', 'Twice a day after meals'),
        _buildMedicineCard('Vitamin D 1000IU', 'Once a day'),
        _buildMedicineCard('Drink water and rest', 'As needed'),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // وظيفة تحميل PDF
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Download PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineCard(String title, String subtitle) {
    return Card(
      color: AppColors.secondaryColor,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.local_hospital, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        subtitle:
            Text(subtitle, style: const TextStyle(color: AppColors.textColor)),
      ),
    );
  }
}
