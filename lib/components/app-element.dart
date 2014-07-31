library contacts.components.app_element;

import 'dart:async';
import 'dart:html';

import 'package:contacts/src/app.dart';
import 'package:contacts/src/contact.dart';
import 'package:contacts/src/sync.dart';
import 'package:polymer/polymer.dart';

@CustomTag('app-element')
class AppElement extends PolymerElement with Observable {
  @published
  String get syncId => readValue(#syncId);
  void set syncId(String value) => writeValue(#syncId, value);

  @observable
  App get app => readValue(#app);

  AppElement.created() : super.created() {

    //
    // Listen for removeContact event and remove the associated contact
    //
    on['removeContact'].listen((event) {
      var contact = event.detail as Contact;

      if (app == null) return;
      app.remove(contact);
    });

    Polymer.onReady.then((_) {
      return new Future(() => _polymerReady());
    });
  }

  void saveHandler(CustomEvent event) {
    var contact = event.detail as Contact;

    if (app == null) return;
    app.add(contact);
  }

  void _loadApp(Sync sync) {
    assert(app == null);
    writeValue(#app, new App(sync: sync));
  }

  void _polymerReady() {
    assert(app == null);
    if (syncId == null) return;

    var sync = document.querySelector('#$syncId') as Sync;
    _loadApp(sync);
  }
}
