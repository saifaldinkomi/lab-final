// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'contact_model.dart';
// import 'contact.dart';
// import 'add_edit_page.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contacts'),
//       ),
//       body: Consumer<ContactModel>(
//         builder: (context, contactModel, child) {
//           // Display a list of contacts
//           return ListView.builder(
//             itemCount: contactModel.contacts.length,
//             itemBuilder: (context, index) {
//               final contact = contactModel.contacts[index];
//               return ListTile(
//                 //circle avatar
//                 leading: CircleAvatar(
//                   child: Text(contact.name[0]),
//                 ),
//                 //title name contact and trailing icon delete
//                 title: Text(contact.name),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () {
//                     contactModel.deleteContact(index);
//                   },
//                 ),
//                 //onTap show dialog contact info 
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Contact Info'),
//                       content: Text(
//                         'Name: ${contact.name}\nPhone: ${contact.phone}',
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('Close'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 //onLongPress navigate to AddEditPage
//                 onLongPress: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           AddEditPage(contact: contact, index: index),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//       // Add a floating action button to add a new contact
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AddEditPage(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_model.dart';
import 'contact.dart';
import 'add_edit_page.dart';

// تعريف صفحة MainPage وهي صفحة StatelessWidget
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // شريط التطبيق العلوي يحتوي على عنوان
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      // جسم الصفحة يستخدم Consumer لمراقبة البيانات
      body: Consumer<ContactModel>(
        builder: (context, contactModel, child) {
          // عرض قائمة جهات الاتصال باستخدام ListView.builder
          return ListView.builder(
            itemCount: contactModel.contacts.length, // عدد العناصر
            itemBuilder: (context, index) {
              final contact = contactModel.contacts[index];
              return ListTile(
                // الصورة الرمزية تعرض أول حرف من الاسم
                leading: CircleAvatar(
                  child: Text(contact.name[0]),
                ),
                // عنوان جهة الاتصال وزر الحذف
                title: Text(contact.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    contactModel.deleteContact(index); // حذف جهة الاتصال
                  },
                ),
                // عند الضغط، تظهر نافذة تعرض معلومات جهة الاتصال
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Contact Info'),
                      content: Text(
                        'Name: ${contact.name}\nPhone: ${contact.phone}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                // عند الضغط مع الاستمرار، يتم الانتقال إلى صفحة التعديل
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddEditPage(contact: contact, index: index),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      // زر عائم لإضافة جهة اتصال جديدة
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditPage(), // الانتقال إلى صفحة الإضافة
            ),
          );
        },
      ),
    );
  }
}
