library contacts.contact;

class Contact {
  int id;
  String name;
  String notes;
  bool important;

  Contact(this.name, this.notes, this.important, this.id);

  factory Contact.fromJson(Map json) =>
      new Contact(json['name'], json['notes'], json['important'], json['id']);

  Map toJson() {
    var map = {
      'name': name,
      'notes': notes,
      'important': important
    };

    if (id != null) map['id'] = id;
    return map;
  }
}
