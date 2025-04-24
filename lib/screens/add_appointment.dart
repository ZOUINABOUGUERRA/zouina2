import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/routes/app_routes.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool isWeekly = true;

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final TextEditingController _maxLimitController = TextEditingController();

  String? _startError;
  String? _endError;
  String? _limitError;

  Future<void> _pickTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _saveAppointment() {
    setState(() {
      _startError = _startTime == null ? 'Start time is required' : null;
      _endError = _endTime == null ? 'End time is required' : null;
      _limitError =
          _maxLimitController.text.isEmpty ? 'Limit is required' : null;
    });

    if (_startError == null && _endError == null && _limitError == null) {
      // Save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment saved')),
      );
    }
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildCalendarToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isWeekly = true;
                  _calendarFormat = CalendarFormat.week;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isWeekly ? AppColors.primary : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.view_week,
                        color: isWeekly ? Colors.white : AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Weekly',
                      style: TextStyle(
                        color: isWeekly ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isWeekly = false;
                  _calendarFormat = CalendarFormat.month;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isWeekly ? AppColors.primary : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month,
                        color: !isWeekly ? Colors.white : AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Monthly',
                      style: TextStyle(
                        color: !isWeekly ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Add Appointment"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCalendarToggle(),
                TableCalendar(
                  locale: 'en',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.access_time,
                            color: AppColors.primary),
                        title: const Text("Start Time"),
                        trailing: Text(
                          _startTime?.format(context) ?? "Select",
                          style: const TextStyle(color: AppColors.textColor),
                        ),
                        onTap: () => _pickTime(context, true),
                      ),
                      if (_startError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(_startError!,
                              style:
                                  const TextStyle(color: AppColors.errorColor)),
                        ),
                    ],
                  ),
                ),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.access_time_filled,
                            color: AppColors.primary),
                        title: const Text("End Time"),
                        trailing: Text(
                          _endTime?.format(context) ?? "Select",
                          style: const TextStyle(color: AppColors.textColor),
                        ),
                        onTap: () => _pickTime(context, false),
                      ),
                      if (_endError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(_endError!,
                              style:
                                  const TextStyle(color: AppColors.errorColor)),
                        ),
                    ],
                  ),
                ),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _maxLimitController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Maximum Limit",
                          prefixIcon: Icon(Icons.numbers),
                          border: InputBorder.none,
                        ),
                      ),
                      if (_limitError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(_limitError!,
                              style:
                                  const TextStyle(color: AppColors.errorColor)),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text("Save Appointment"),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.showAppointment);
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: const Text("Show Appointments"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
