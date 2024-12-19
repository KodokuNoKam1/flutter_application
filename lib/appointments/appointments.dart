import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'appointmentsEntry.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  DateTime _selectedDate = DateTime.now();
  final Map<DateTime, List<String>> _appointments = {};

  void _addAppointment(String title, DateTime date) {
    setState(() {
      if (_appointments[date] == null) {
        _appointments[date] = [];
      }
      _appointments[date]?.add(title);
    });
  }

  void _editAppointment(
      DateTime originalDate, int index, String originalTitle) {
    DateTime editedDate = originalDate;
    TextEditingController titleController =
        TextEditingController(text: originalTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration:
                    const InputDecoration(labelText: 'Appointment Title'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: editedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      editedDate = pickedDate;
                    });
                  }
                },
                child: const Text('Change Date'),
              ),
              Text('Selected Date: ${DateFormat.yMMMd().format(editedDate)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _appointments[originalDate]?.removeAt(index);
                  if (_appointments[originalDate]?.isEmpty ?? false) {
                    _appointments.remove(originalDate);
                  }
                  if (_appointments[editedDate] == null) {
                    _appointments[editedDate] = [];
                  }
                  _appointments[editedDate]?.add(titleController.text);
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAppointmentsForDate(DateTime date) {
    List<String>? appointments = _appointments[date];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointments for ${DateFormat.yMMMd().format(date)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (appointments != null && appointments.isNotEmpty)
                ...appointments.asMap().entries.map(
                  (entry) {
                    int index = entry.key;
                    String appointment = entry.value;

                    return ListTile(
                      title: Text(appointment),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.pop(context);
                              _editAppointment(date, index, appointment);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _appointments[date]?.removeAt(index);
                                if (_appointments[date]?.isEmpty ?? false) {
                                  _appointments.remove(date);
                                }
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              else
                const Text('No appointments for this date.'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: CalendarCarousel(
        onDayPressed: (date, events) {
          setState(() {
            _selectedDate = date;
          });
          _showAppointmentsForDate(date);
        },
        selectedDayButtonColor: Colors.blue,
        todayButtonColor: Colors.green,
        selectedDateTime: _selectedDate,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentEntry(
                onSave: (title, date) {
                  _addAppointment(title, date);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
