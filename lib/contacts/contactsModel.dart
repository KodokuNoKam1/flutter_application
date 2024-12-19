import 'package:flutter/foundation.dart';
import 'contactsDBWorker.dart';

class Contact {
  int id;
  String name;
  String phone;
  String email;
  String address;
  String avatar;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.avatar = '',
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'avatar': avatar,
    };
    map['id'] = id;
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        phone = map['phone'],
        email = map['email'],
        address = map['address'],
        avatar = map['avatar'];
}

class ContactModel extends ChangeNotifier {
  List<Contact> _contacts = [];
  final ContactsDBWorker _dbWorker = ContactsDBWorker();

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _dbWorker.create(contact).then((_) {
      _contacts.add(contact);
      notifyListeners();
    });
  }

  void deleteContact(int id) {
    _dbWorker.delete(id).then((_) {
      _contacts.removeWhere((contact) => contact.id == id);
      notifyListeners();
    });
  }

  void loadContacts() async {
    _contacts = await _dbWorker.getAll();
    notifyListeners();
  }
}

final contactModel = ContactModel();
