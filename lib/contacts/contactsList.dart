import 'package:flutter/material.dart';
import 'contactsModel.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactModel>(
      builder: (context, model, child) {
        if (model.contacts.isEmpty) {
          return Center(
            child: Text('Нет контактов'),
          );
        }

        return ListView.builder(
          itemCount: model.contacts.length,
          itemBuilder: (context, index) {
            var contact = model.contacts[index];
            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.phone),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.deleteContact(contact.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
