library contacts.components.app_element;

import 'dart:async';
import 'dart:html';

import 'package:io_2014_contacts_demo/src/app.dart';
import 'package:io_2014_contacts_demo/src/contact.dart';
import 'package:io_2014_contacts_demo/src/sync.dart';
import 'package:polymer/polymer.dart';

@CustomTag('app-element')
class AppElement extends PolymerElement with Observable {
  @published String syncId;
  @observable App app;

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
    app = new App(sync: sync);
  }

  void _polymerReady() {
    assert(app == null);
    if (syncId == null) return;

    var sync = document.querySelector('#$syncId') as Sync;
    _loadApp(sync);
  }
}
