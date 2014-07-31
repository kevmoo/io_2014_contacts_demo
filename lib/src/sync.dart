library contacts.sync;

import 'dart:async';

import 'contact.dart';

abstract class Sync {
  factory Sync() = _MemorySync;

  Future<List<Contact>> load();

  Future<Contact> add(Contact contact);

  Future<bool> delete(Contact contact);
}

class _MemorySync implements Sync {
  final List<Contact> _contacts = new List<Contact>();

  _MemorySync() {
    _contacts.add(new Contact('John Moore', 'birthday June 25', true, null));
    _contacts.add(new Contact('Bob Jones', 'Foo', false, null));
    _contacts.add(new Contact('Shanna Alvare', 'Birthday June 5', true, null));
  }

  Future<List<Contact>> load() {
    return new Future.value(_contacts.toList());
  }

  Future<Contact> add(Contact contact) {
    assert(contact != null);
    _contacts.add(contact);
    return new Future.value(contact);
  }

  Future<bool> delete(Contact contact) {
    var removed = _contacts.remove(contact);
    return new Future.value(removed);
  }
}
