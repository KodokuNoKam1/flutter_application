import 'package:flutter/material.dart';
import 'contactsModel.dart';
import 'package:provider/provider.dart';

class ContactsEntry extends StatefulWidget {
  const ContactsEntry({super.key});

  @override
  _ContactsEntryState createState() => _ContactsEntryState();
}

class _ContactsEntryState extends State<ContactsEntry> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _email;
  String? _address;
  String? _avatar;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Имя'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите имя';
              }
              return null;
            },
            onSaved: (value) {
              _name = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Телефон'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите телефон';
              }
              return null;
            },
            onSaved: (value) {
              _phone = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Электронная почта'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите электронную почту';
              }
              return null;
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Адрес'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите адрес';
              }
              return null;
            },
            onSaved: (value) {
              _address = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Аватар (URL изображения)'),
            onSaved: (value) {
              _avatar = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                if (_name != null &&
                    _phone != null &&
                    _email != null &&
                    _address != null) {
                  Provider.of<ContactModel>(context, listen: false)
                      .addContact(Contact(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: _name!,
                    phone: _phone!,
                    email: _email!,
                    address: _address!,
                    avatar: _avatar ?? '',
                  ));
                }
              }
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
