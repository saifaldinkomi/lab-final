// import 'package:final_lab/invoice_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class DetailsPage extends StatelessWidget {
  
//   const DetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Consumer<InvoiceModel>(builder: (context, value, child) {
//           return Text(value.getSelectedInvoice().name);
//         },)
//       ),
//       body: Consumer<InvoiceModel>(builder: (context, value, child) {
//         return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Invoice No: ${value.getSelectedInvoice().id}',
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           ),
//           Text(
//             'Products:',
//             style: TextStyle(fontSize: 30, color: Colors.red),
//           ),
//           Text(
//             value.getSelectedInvoice().toString(),
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           ),
//         ],
//       );
//       },)
//     );
//   }
// }


import 'package:final_lab/invoice_model.dart'; // استيراد نموذج الفواتير لإدارة البيانات
import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لبناء واجهات المستخدم
import 'package:provider/provider.dart'; // استيراد مكتبة Provider لإدارة الحالة

class DetailsPage extends StatelessWidget {
  
  const DetailsPage({super.key}); // منشئ الصفحة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // تعيين لون شريط التطبيق العلوي إلى الأزرق
        title: Consumer<InvoiceModel>(builder: (context, value, child) {
          // استخدام Consumer للوصول إلى InvoiceModel والقراءة منها
          return Text(value.getSelectedInvoice().name); // عرض اسم الفاتورة المحددة في العنوان
        },)
      ),
      body: Consumer<InvoiceModel>(builder: (context, value, child) {
        // استخدام Consumer للوصول إلى InvoiceModel في الجسم وتحديث واجهة المستخدم بناءً على التغييرات
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النصوص على اليسار
        children: [
          Text(
            'Invoice No: ${value.getSelectedInvoice().id}', // عرض رقم الفاتورة
            style: TextStyle(
              fontSize: 20, // تحديد حجم الخط
            ),
          ),
          Text(
            'Products:', // نص "المنتجات" باللون الأحمر
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          Text(
            value.getSelectedInvoice().toString(), // عرض تفاصيل الفاتورة كـ نص
            style: TextStyle(
              fontSize: 20, // تحديد حجم الخط
            ),
          ),
        ],
      );
      },)
    );
  }
}
