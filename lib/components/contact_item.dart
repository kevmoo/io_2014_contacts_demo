library contacts.components.contact_item;

import 'package:io_2014_contacts_demo/src/contact.dart';
import 'package:polymer/polymer.dart';

@CustomTag('contact-item')
class ContactItem extends PolymerElement {
  @published
  Contact get contact => readValue(#contact);
  void set contact(Contact value) => writeValue(#contact, value);

  ContactItem.created() : super.created();

  void removeAction() {
    fire('removeContact', detail: contact);
  }
}
