library contacts.components.contact_edit;

import 'package:contacts/src/contact.dart';
import 'package:polymer/polymer.dart';

@CustomTag('contact-edit')
class ContactEdit extends PolymerElement with Observable {
  @published bool open = false;
  @observable String name;
  @observable String notes;
  @observable bool important;

  ContactEdit.created() : super.created();

  void ready() {
    super.ready();
    _clear();
  }

  void openAction() {
    assert(!open);
    open = true;
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
    open = false;
  }
}
