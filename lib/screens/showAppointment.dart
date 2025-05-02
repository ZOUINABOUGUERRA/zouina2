import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:meditim_assistance/constants/colors.dart'; // AppColors

class ShowAppointmentPage extends StatefulWidget {
  const ShowAppointmentPage({super.key});

  @override
  _ShowAppointmentPageState createState() => _ShowAppointmentPageState();
}

class _ShowAppointmentPageState extends State<ShowAppointmentPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<Appointment>> _appointments = {
    DateTime(2025, 4, 15): [
      Appointment(
        time: "10:00 AM - 11:00 AM",
        people: ["John Doe", "Emily Smith"],
      ),
    ],
    DateTime(2025, 4, 20): [
      Appointment(
        time: "02:00 PM - 03:30 PM",
        people: ["Ahmed Johnson"],
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Appointments"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildHeader(),
            const SizedBox(height: 8),
            _buildCalendar(),
            const SizedBox(height: 16),
            _buildAppointmentsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            color: AppColors.textColor,
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(
                    _focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
              });
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                DateFormat.yMMMM().format(_focusedDay),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            color: AppColors.textColor,
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(
                    _focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _periodButton(String label, CalendarFormat format) {
    final isSelected = _calendarFormat == format;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
        side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.textColor),
      ),
      onPressed: () {
        setState(() => _calendarFormat = format);
      },
      child: Text(
        label,
        style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textColor),
      ),
    );
  }

  Widget _buildViewToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _periodButton("Weekly", CalendarFormat.week),
          const SizedBox(width: 8),
          _periodButton("Monthly", CalendarFormat.month),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      locale: 'en_US',
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onFormatChanged: (format) => setState(() => _calendarFormat = format),
      onDaySelected: (selected, focused) {
        setState(() {
          _selectedDay = selected;
          _focusedDay = focused;
        });
      },
      headerVisible: false,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: const TextStyle(color: AppColors.errorColor),
        defaultTextStyle: const TextStyle(color: AppColors.textColor),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
        weekendStyle:
            TextStyle(fontWeight: FontWeight.bold, color: AppColors.errorColor),
      ),
      rowHeight: 40,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Monthly',
        CalendarFormat.week: 'Weekly',
      },
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              DateFormat.E().format(day),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
          );
        },
        headerTitleBuilder: (context, day) => _buildViewToggle(),
      ),
    );
  }

  Widget _buildAppointmentsSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _selectedDay == null
          ? Padding(
              key: const ValueKey(0),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Select a date to view appointments",
                style: TextStyle(
                    color: AppColors.textColor.withOpacity(0.6), fontSize: 16),
              ),
            )
          : _buildAppointmentCard(key: ValueKey(_selectedDay)),
    );
  }

  Widget _buildAppointmentCard({required Key key}) {
    final date = _selectedDay!;
    final appointments =
        _appointments[DateTime(date.year, date.month, date.day)] ?? [];

    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${DateFormat.d().format(date)} ${DateFormat.MMMM().format(date)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (appointments.isEmpty)
            Text("No appointments for this day",
                style: TextStyle(color: AppColors.textColor.withOpacity(0.8)))
          else
            ...appointments.map((appt) => _buildAppointmentItem(appt)),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(Appointment appt) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.access_time, color: AppColors.primary),
        title: Text(
          appt.time,
          style: const TextStyle(color: AppColors.textColor),
        ),
        subtitle: Wrap(
          spacing: 6,
          children: appt.people
              .map((p) => Chip(
                    label: Text(p,
                        style: const TextStyle(color: AppColors.textColor)),
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    visualDensity: VisualDensity.compact,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class Appointment {
  final String time;
  final List<String> people;
  Appointment({required this.time, required this.people});
}
