library contacts.components.contact_edit;

import 'package:contacts/src/contact.dart';
import 'package:polymer/polymer.dart';

@CustomTag('contact-edit')
class ContactEdit extends PolymerElement with Observable {
  @published
  bool get open => readValue(#open, () => false);

  @observable
  String get name => readValue(#name, () => '');
  void set name(String value) => writeValue(#name,  value);

  @observable
  String get notes => readValue(#notes, () => '');
  void set notes(String value) => writeValue(#notes,  value);

  @observable
  bool get important => readValue(#important, () => '');
  void set important(bool value) => writeValue(#important,  value);

  ContactEdit.created() : super.created();

  void ready() {
    super.ready();
    _clear();
  }

  void openAction() {
    assert(!open);
    writeValue(#open, true);
  }

  void saveAction() {
    assert(open);
    fire('save', detail: new Contact(name, notes, important, null));
    _clear();
  }

  void cancelAction() {
    assert(open);
    _clear();
  }

  void _clear() {
    name = '';
    notes = '';
    important = false;
    writeValue(#open, false);
  }
}
