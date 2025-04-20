import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:meditim_assistance/constants/colors.dart';

class AddweeklyAppointmentPage extends StatefulWidget {
  const AddweeklyAppointmentPage({super.key});

  @override
  State<AddweeklyAppointmentPage> createState() =>
      _AddWeeklyAppointmentPageState();
}

class _AddWeeklyAppointmentPageState extends State<AddweeklyAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDay = DateTime.now();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();

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
    }
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: AppColors.secondaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('إضافة موعد أسبوعي'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() => _calendarFormat = format);
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: true,
                    formatButtonShowsNext: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  locale: 'ar_AR',
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _startTimeController,
                  decoration: _inputDecoration('وقت البداية', 'أدخل الساعة'),
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _endTimeController,
                  decoration: _inputDecoration('وقت النهاية', 'أدخل الساعة'),
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _limitController,
                  decoration: _inputDecoration('الحد الأقصى', 'أدخل العدد'),
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
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
