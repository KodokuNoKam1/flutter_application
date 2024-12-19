import 'package:flutter/foundation.dart'; // Для использования ChangeNotifier

class Appointment {
  String title;
  DateTime date;

  Appointment({required this.title, required this.date});
}

class AppointmentsModel extends ChangeNotifier {
  final List<Appointment> _appointments = [];

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void loadAppointments() {
    _appointments
        .add(Appointment(title: "Пример встречи", date: DateTime.now()));
    notifyListeners();
  }
}
