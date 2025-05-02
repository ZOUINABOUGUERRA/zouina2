import 'package:flutter/material.dart';
import 'package:meditim_assistance/screens/home_assistance_screen.dart';
import 'package:meditim_assistance/screens/page_archiv.dart';
import 'package:meditim_assistance/screens/today_appointments.dart';
import 'package:meditim_assistance/screens/page_Confirmed_Appointments.dart';
import 'app_routes.dart';
import 'package:meditim_assistance/screens/page_details_patient.dart';
import 'package:meditim_assistance/screens/page_setting_assistant.dart';
import 'package:meditim_assistance/screens/page_midical file.dart';
import 'package:meditim_assistance/screens/modify_information_of_cilinc.dart';
import 'package:meditim_assistance/screens/add_appointment.dart';
import 'package:meditim_assistance/screens/showAppointment.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRoutes.showAppointment:
        return MaterialPageRoute(
          builder: (_) => const ShowAppointmentPage(),
        );

      case AppRoutes.todayAppointments:
        return MaterialPageRoute(
          builder: (_) => const TodayAppointmentsScreen(),
        );

      case AppRoutes.confirmedAppointments:
        return MaterialPageRoute(
          builder: (_) => const ConfirmedAppointmentsScreen(),
        );

      case AppRoutes.pageArchiv:
        return MaterialPageRoute(
          builder: (_) => const ArchiveScreen(),
        );

      case AppRoutes.pageDetailsPatient:
        return MaterialPageRoute(
          builder: (_) => const PatientProfileCard(),
        );

      case AppRoutes.addAppointment:
        return MaterialPageRoute(
          builder: (_) => const AddAppointmentPage(),
        );

      case AppRoutes.pagesettingassistant:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );

      case AppRoutes.pagemidicalfile:
        return MaterialPageRoute(
          builder: (_) => const MedicalFilePage(),
        );

      case AppRoutes.modifyinformationofcilinc:
        return MaterialPageRoute(
          builder: (_) => const ClinicInfoPage(),
        );

      // في حالة طلب روت غير موجود
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Route Found'),
            ),
          ),
        );
    }
  }
}
