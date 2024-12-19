import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appointments/appointments.dart';
import 'appointments/appointmentsModel.dart'; // Правильный импорт
import 'contacts/contacts.dart';
import 'contacts/contactsModel.dart';
import 'notes/notes.dart';
import 'notes/notesModel.dart';
import 'tasks/tasks.dart';
import 'tasks/tasksModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppointmentsModel>(
            create: (_) => AppointmentsModel()..loadAppointments()),
        ChangeNotifierProvider<ContactModel>(
            create: (_) => ContactModel()..loadContacts()),
        ChangeNotifierProvider<NoteModel>(
            create: (_) => NoteModel()..loadNotes()),
        ChangeNotifierProvider<TaskModel>(
            create: (_) => TaskModel()..loadTasks()),
      ],
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Органайзер'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Встречи'),
              Tab(text: 'Контакты'),
              Tab(text: 'Заметки'),
              Tab(text: 'Задачи'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Appointments(),
            Contacts(),
            Notes(),
            Tasks(),
          ],
        ),
      ),
    );
  }
}
