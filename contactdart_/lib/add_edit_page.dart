// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'contact_model.dart';
// import 'contact.dart';


// class AddEditPage extends StatefulWidget {
//   final Contact? contact;
//   final int? index;


//   const AddEditPage({Key? key, this.contact, this.index}) : super(key: key);

//   @override
//   State<AddEditPage> createState() => _AddEditPageState();
// }

// class _AddEditPageState extends State<AddEditPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _phone;

//   @override
//   void initState() {
//     super.initState();
//     _name = widget.contact?.name ?? '';
//     _phone = widget.contact?.phone ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       appBar: AppBar(
//         title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: _name,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _name = value!;
//                 },
//               ),
              
//               TextFormField(
//                 initialValue: _phone,
//                 decoration: const InputDecoration(labelText: 'Phone'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a phone number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _phone = value!;
//                 },
//               ),
              
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     final contact = Contact(name: _name, phone: _phone);
//                     if (widget.contact == null) {
//                       // Add new contact
//                       Provider.of<ContactModel>(context, listen: false)
//                           .addContact(contact);
//                     } else {
//                       // Edit existing contact
//                       Provider.of<ContactModel>(context, listen: false)
//                           .editContact(widget.index!, contact);
//                     }
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text(widget.contact == null
//                     ? 'Add Contact'
//                     : 'Edit Contact'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_model.dart';
import 'contact.dart';

// صفحة لإضافة أو تعديل جهة اتصال
class AddEditPage extends StatefulWidget {
  final Contact? contact; // جهة الاتصال المراد تعديلها (إذا كانت موجودة)
  final int? index; // الفهرس الخاص بجهة الاتصال

  const AddEditPage({Key? key, this.contact, this.index}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>(); // مفتاح النموذج للتحقق من الإدخال
  late String _name; // اسم جهة الاتصال
  late String _phone; // رقم هاتف جهة الاتصال

  @override
  void initState() {
    super.initState();
    // إذا كان كائن جهة الاتصال موجودًا، يتم تهيئة الحقول بقيمه
    _name = widget.contact?.name ?? '';
    _phone = widget.contact?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // شريط التطبيق العلوي
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // حقل إدخال الاسم
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name'; // تحقق من صحة الاسم
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!; // حفظ القيمة
                },
              ),
              // حقل إدخال رقم الهاتف
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number'; // تحقق من صحة الرقم
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!; // حفظ القيمة
                },
              ),
              const SizedBox(height: 20),
              // زر الحفظ
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // حفظ البيانات
                    final contact = Contact(name: _name, phone: _phone);
                    if (widget.contact == null) {
                      // إذا لم يكن هناك جهة اتصال، يتم الإضافة
                      Provider.of<ContactModel>(context, listen: false)
                          .addContact(contact);
                    } else {
                      // إذا كانت جهة الاتصال موجودة، يتم التعديل
                      Provider.of<ContactModel>(context, listen: false)
                          .editContact(widget.index!, contact);
                    }
                    Navigator.pop(context); // العودة إلى الصفحة السابقة
                  }
                },
                child: Text(widget.contact == null
                    ? 'Add Contact' // إذا كانت إضافة
                    : 'Edit Contact'), // إذا كانت تعديل
              ),
            ],
          ),
        ),
      ),
    );
  }
}
