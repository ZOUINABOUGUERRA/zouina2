import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';

class AssistantProfilePage extends StatefulWidget {
  const AssistantProfilePage({super.key});

  @override
  State<AssistantProfilePage> createState() => _AssistantProfilePageState();
}

class _AssistantProfilePageState extends State<AssistantProfilePage> {
  bool isEditing = false;

  final TextEditingController nameController =
      TextEditingController(text: 'سارة الإدريسي');
  final TextEditingController emailController =
      TextEditingController(text: 'sara@example.com');
  final TextEditingController phoneController =
      TextEditingController(text: '+213 600 000 000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'ملف المساعد',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit,
                color: AppColors.whiteColor),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حفظ التغييرات',
                          textDirection: TextDirection.rtl),
                    ),
                  );
                }
                isEditing = !isEditing;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/assistant.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'معلومات المساعد',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 30),
            _buildFieldCard(label: 'الاسم', controller: nameController),
            const SizedBox(height: 16),
            _buildFieldCard(
                label: 'البريد الإلكتروني', controller: emailController),
            const SizedBox(height: 16),
            _buildFieldCard(label: 'رقم الهاتف', controller: phoneController),
            const SizedBox(height: 30),
            if (isEditing)
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('حفظ التغييرات'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ التغييرات')),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldCard({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
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
      child: TextField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: isEditing ? Colors.white : Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: const TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
