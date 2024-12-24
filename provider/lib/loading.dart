// import 'dart:convert';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:final_lab/invoice_model.dart';
// import 'main.dart';
// import 'invoice.dart';
// import 'package:provider/provider.dart';

// fetchInvoices(BuildContext context) async {
//   var response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/TT8U'));
//   if (response.statusCode == 200) {
//     var jsonArr = jsonDecode(response.body)['invoices'] as List;
//     // Provider.of<InvoiceModel>(context, listen: false).invoices =
//     // jsonArr.map((e) => Invoice.fromJson(e)).toList();
//     context.read<InvoiceModel>().invoices =
//         jsonArr.map((e) => Invoice.fromJson(e)).toList();
//   }
//   Navigator.pop(context);
//   Navigator.pushReplacementNamed(context, '/');
// }

// class Loading extends StatefulWidget {
//   const Loading({super.key});

//   @override
//   State<Loading> createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchInvoices(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Center(
//         child: SpinKitPouringHourGlass(
//           duration: Duration(
//             milliseconds: 1000,
//           ),
//           color: Colors.white,
//           size: 50.0,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert'; // استيراد مكتبة لتحويل النصوص JSON.
import 'package:flutter_spinkit/flutter_spinkit.dart'; // استيراد مكتبة لإنشاء تأثيرات التحميل.
import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لبناء واجهات المستخدم.
import 'package:http/http.dart' as http; // استيراد مكتبة http للتعامل مع طلبات الويب.
import 'package:final_lab/invoice_model.dart'; // استيراد نموذج الفواتير.
import 'main.dart'; // استيراد الملف الرئيسي للتطبيق.
import 'invoice.dart'; // استيراد فئة الفواتير.
import 'package:provider/provider.dart'; // استيراد مكتبة Provider لإدارة الحالة.

// وظيفة لجلب الفواتير من API وتخزينها في نموذج الفواتير.
fetchInvoices(BuildContext context) async {
  // إرسال طلب GET للحصول على بيانات الفواتير من واجهة API.
  var response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/TT8U'));

  if (response.statusCode == 200) { // التحقق إذا كان الطلب ناجحًا.
    var jsonArr = jsonDecode(response.body)['invoices'] as List;
    // فك تشفير استجابة JSON واستخراج قائمة الفواتير.

    // تعيين البيانات إلى قائمة الفواتير في InvoiceModel باستخدام Provider.
    context.read<InvoiceModel>().invoices =
        jsonArr.map((e) => Invoice.fromJson(e)).toList();
  }

  // إغلاق شاشة التحميل.
  Navigator.pop(context);
  // الانتقال إلى الصفحة الرئيسية باستخدام استبدال المسار.
  Navigator.pushReplacementNamed(context, '/');
}

class Loading extends StatefulWidget {
  const Loading({super.key}); // تعريف عنصر واجهة قابل للتحديث.

  @override
  State<Loading> createState() => _LoadingState(); // إنشاء الحالة المقابلة للواجهة.
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // استدعاء الوظيفة عند بدء تحميل الصفحة.
    super.initState(); // استدعاء التهيئة الأساسية.
    fetchInvoices(context); // تحميل الفواتير من API.
  }

  @override
  Widget build(BuildContext context) {
    // تصميم واجهة شاشة التحميل.
    return Scaffold(
      backgroundColor: Colors.blue, // تعيين لون الخلفية إلى الأزرق.
      body: Center(
        // عرض عنصر التحميل في المنتصف.
        child: SpinKitPouringHourGlass(
          duration: Duration(
            milliseconds: 1000, // تحديد مدة الرسوم المتحركة بالمللي ثانية.
          ),
          color: Colors.white, // تحديد اللون الأبيض للعنصر.
          size: 50.0, // تحديد حجم العنصر.
        ),
      ),
    );
  }
}
