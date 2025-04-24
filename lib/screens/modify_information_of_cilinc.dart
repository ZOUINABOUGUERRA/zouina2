import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditim_assistance/constants/colors.dart';

class ClinicInfoPage extends StatefulWidget {
  const ClinicInfoPage({super.key});

  @override
  State<ClinicInfoPage> createState() => _ClinicInfoPageState();
}

class _ClinicInfoPageState extends State<ClinicInfoPage> {
  final TextEditingController clinicNameController =
      TextEditingController(text: 'Al Shifa Clinic');
  final TextEditingController clinicAddressController =
      TextEditingController(text: 'Prince Abdelkader Street, Algiers');
  final List<TextEditingController> doctorControllers = [
    TextEditingController(text: 'Dr. Ahmed Zahrawi'),
  ];

  File? clinicImage;

  void _addDoctor() {
    setState(() {
      doctorControllers.add(TextEditingController());
    });
  }

  void _removeDoctor(int index) {
    setState(() {
      doctorControllers.removeAt(index);
    });
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Clinic information saved')),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        clinicImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Clinic Information'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Clinic Image'),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  image: clinicImage != null
                      ? DecorationImage(
                          image: FileImage(clinicImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: clinicImage == null
                    ? const Center(
                        child: Icon(Icons.add_a_photo,
                            size: 40, color: AppColors.primary),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Clinic Name'),
            _buildTextField(controller: clinicNameController),
            const SizedBox(height: 16),
            _buildSectionTitle('Clinic Address'),
            _buildTextField(controller: clinicAddressController),
            const SizedBox(height: 16),
            _buildSectionTitle('Clinic Doctors'),
            ...doctorControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: controller,
                        label: 'Doctor Name ${index + 1}',
                      ),
                    ),
                    if (doctorControllers.length > 1)
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: AppColors.errorColor),
                        onPressed: () => _removeDoctor(index),
                      ),
                  ],
                ),
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _addDoctor,
                icon: const Icon(Icons.add, color: AppColors.primary),
                label: const Text(
                  'Add Doctor',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
