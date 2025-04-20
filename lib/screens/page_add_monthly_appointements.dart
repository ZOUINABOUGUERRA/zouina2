import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:meditim_assistance/constants/colors.dart';

class AddMonthlyAppointmentPage extends StatefulWidget {
  const AddMonthlyAppointmentPage({super.key});

  @override
  State<AddMonthlyAppointmentPage> createState() =>
      _AddMonthlyAppointmentPageState();
}

class _AddMonthlyAppointmentPageState extends State<AddMonthlyAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDay = DateTime.now();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newAppointment = {
        'date': _selectedDay,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
        'limit': _limitController.text,
      };

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ShowMonthlyAppointments(appointment: newAppointment),
        ),
      );
    }
  }

  InputDecoration customInputDecoration(
      String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: AppColors.whiteColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('إضافة موعد جديد'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _selectedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, _) {
                        setState(() => _selectedDay = selectedDay);
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: const CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      locale: 'ar_AR',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _startTimeController,
                  decoration: customInputDecoration(
                      'وقت البداية', 'أدخل الساعة', Icons.access_time),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال وقت البداية';
                    }
                    final hour = int.tryParse(value);
                    if (hour == null || hour < 0 || hour > 24) {
                      return 'وقت غير صالح (1-24)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _endTimeController,
                  decoration: customInputDecoration(
                      'وقت النهاية', 'أدخل الساعة', Icons.access_time_outlined),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال وقت النهاية';
                    }
                    final endHour = int.tryParse(value);
                    final startHour = int.tryParse(_startTimeController.text);
                    if (endHour == null || endHour < 0 || endHour > 24) {
                      return 'وقت غير صالح (1-24)';
                    }
                    if (startHour != null && endHour <= startHour) {
                      return 'وقت النهاية يجب أن يكون بعد البداية';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _limitController,
                  decoration: customInputDecoration(
                      'الحد الأقصى', 'أدخل العدد', Icons.person),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الحد الأقصى';
                    }
                    if (int.tryParse(value) == null) {
                      return 'رقم غير صالح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add, color: AppColors.whiteColor),
                  label: const Text(
                    'إضافة موعد',
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowMonthlyAppointments extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const ShowMonthlyAppointments({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الموعد المضاف'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' التاريخ: ${appointment['date'].toString()}',
                    style: const TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600)),
                Text(' وقت البداية: ${appointment['startTime']}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 152, 150, 150),
                        fontWeight: FontWeight.w600)),
                Text(' وقت النهاية: ${appointment['endTime']}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 152, 150, 150),
                        fontWeight: FontWeight.w600)),
                Text(' الحد الأقصى: ${appointment['limit']}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 152, 150, 150),
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
