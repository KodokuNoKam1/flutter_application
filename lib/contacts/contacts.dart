import 'package:flutter/material.dart';
import 'contactsList.dart';
import 'contactsEntry.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Контакты'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Text('Список', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: Text('Ввод', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _selectedIndex == 0 ? ContactsList() : ContactsEntry(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
