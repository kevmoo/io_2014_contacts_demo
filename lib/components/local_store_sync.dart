library contacts.local_store_sync;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:contacts/src/contact.dart';
import 'package:contacts/src/sync.dart';
import 'package:polymer/polymer.dart';

const _JSON_ENCODER = const JsonEncoder.withIndent('  ');

@CustomTag('local-store-sync')
class LocalStoreSync extends PolymerElement implements Sync {
  static const _CONTACT_KEY = 'contacts_key_v001';
  final Storage _storage;
  final List<Contact> _cache = new List<Contact>();

  LocalStoreSync.created()
      : _storage = window.localStorage,
        super.created() {
    _updateCache();
  }

  Future<List<Contact>> load() {
    _updateCache();
    return new Future.value(_cache.toList());
  }

  Future<Contact> add(Contact contact) {
    _cache.add(contact);
    _updateStore();
    return new Future.value(contact);
  }

  Future<bool> delete(Contact contact) {
    var removed = _cache.remove(contact);
    if (removed) {
      _updateStore();
    }
    return new Future.value(removed);
  }

  void _updateCache() {
    var json = _storage[_CONTACT_KEY];

    if (json == null) json = '[]';

    var items = JSON.decode(json) as List;

    _cache.clear();
    _cache.addAll(items.map((j) => new Contact.fromJson(j)));
  }

  void _updateStore() {
    var jsonList = _cache.map((c) => c.toJson()).toList();

    _storage[_CONTACT_KEY] = _JSON_ENCODER.convert(jsonList);
  }
}
