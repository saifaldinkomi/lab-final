// import 'package:flutter/material.dart';
// import 'contact.dart';

// class ContactModel extends ChangeNotifier {
//   final List<Contact> _contacts = [];

//   List<Contact> get contacts => List.unmodifiable(_contacts);
// // add contact to list
//   void addContact(Contact contact) {
//     _contacts.add(contact);
//     notifyListeners();
//   }

//   void editContact(int index, Contact newContact) {
//     _contacts[index] = newContact;
//     notifyListeners();
//   }

//   void deleteContact(int index) {
//     _contacts.removeAt(index);
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'contact.dart';

// تعريف نموذج ContactModel الذي يستخدم ChangeNotifier لإدارة الحالة
class ContactModel extends ChangeNotifier {
  // قائمة خاصة (private) لتخزين جهات الاتصال
  final List<Contact> _contacts = [];

  // Getter لإرجاع نسخة غير قابلة للتعديل من قائمة جهات الاتصال
  List<Contact> get contacts => List.unmodifiable(_contacts);

  // وظيفة لإضافة جهة اتصال جديدة إلى القائمة
  void addContact(Contact contact) {
    _contacts.add(contact); // إضافة جهة الاتصال إلى القائمة
    notifyListeners(); // إعلام المستمعين بحدوث تغيير
  }

  // وظيفة لتعديل جهة اتصال موجودة بناءً على الفهرس
  void editContact(int index, Contact newContact) {
    _contacts[index] = newContact; // تحديث جهة الاتصال
    notifyListeners(); // إعلام المستمعين بحدوث تغيير
  }

  // وظيفة لحذف جهة اتصال من القائمة بناءً على الفهرس
  void deleteContact(int index) {
    _contacts.removeAt(index); // حذف جهة الاتصال
    notifyListeners(); // إعلام المستمعين بحدوث تغيير
  }
}
 