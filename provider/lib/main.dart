// import 'package:flutter/material.dart';
// import 'package:final_lab/invoice_model.dart';
// import 'package:provider/provider.dart';
// import 'details_page.dart';
// import 'invoices_list.dart';
// import 'invoice.dart';
// import 'loading.dart';
// import 'product.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (context) => InvoiceModel(),
//         builder: (context, child) => MaterialApp(
//               initialRoute: '/loading',
//               routes: {
//                 '/': (context) => InvoiceApp(),
//                 '/invoices_list': (context) => InvoicesList(),
//                 '/details_page': (context) => DetailsPage(),
//                 '/loading': (context) => Loading(),
//               },
//             ));
//   }
// }

// TextEditingController cNameController = TextEditingController();
// TextEditingController pNameController = TextEditingController();
// TextEditingController quantityController = TextEditingController();
// TextEditingController priceController = TextEditingController();
// List<Product> products = [
//   Product(name: 'Mouse', quantity: 10, price: 20.3),
//   Product(name: 'Ram', quantity: 5, price: 150.5),
// ];

// class InvoiceApp extends StatefulWidget {
//   const InvoiceApp({super.key});
//   static int invoiceNo = 1;

//   @override
//   State<InvoiceApp> createState() => _InvoiceAppState();
// }

// class _InvoiceAppState extends State<InvoiceApp> {
//   @override
//   Widget build(BuildContext context) {
//     if (!context.read<InvoiceModel>().isEmpty()) {
//       InvoiceApp.invoiceNo = context.read<InvoiceModel>().getLast().id + 1;
//     } else {
//       InvoiceApp.invoiceNo = 1;
//     }

//     return Consumer<InvoiceModel>(
//       builder: (context, value, child) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.blue,
//             title: Text('Invoice# ${InvoiceApp.invoiceNo}'),
//           ),
//           body: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: cNameController,
//                 decoration: InputDecoration(
//                   labelText: 'customer name',
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     'Products',
//                     style: TextStyle(fontSize: 22),
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('Product Info'),
//                             content: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   TextField(
//                                     controller: pNameController,
//                                     decoration:
//                                         InputDecoration(labelText: 'name'),
//                                   ),
//                                   TextField(
//                                     controller: quantityController,
//                                     decoration:
//                                         InputDecoration(labelText: 'quantity'),
//                                   ),
//                                   TextField(
//                                     controller: priceController,
//                                     decoration:
//                                         InputDecoration(labelText: 'price'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             actions: [
//                               ElevatedButton(
//                                   onPressed: () {
//                                     try {
//                                       setState(() {
//                                         products.add(Product(
//                                             name: pNameController.text,
//                                             quantity: int.parse(
//                                                 quantityController.text),
//                                             price: double.parse(
//                                                 priceController.text)));
//                                       });
//                                       pNameController.clear();
//                                       quantityController.clear();
//                                       priceController.clear();
//                                       Navigator.pop(context);
//                                     } catch (e) {
//                                       SnackBar snack = SnackBar(
//                                           content: Text(
//                                               'please fill all feilds correctly'));
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(snack);
//                                     }
//                                   },
//                                   child: Text('add')),
//                               ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('cancel')),
//                             ],
//                           ),
//                         );
//                       },
//                       child: Text('add product')),
//                 ],
//               ),
//               Expanded(
//                   child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListTile(
//                       tileColor: Colors.blue[300],
//                       leading: Text(
//                         products[index].name,
//                         style: TextStyle(fontSize: 22),
//                       ),
//                       title: Text('price ${products[index].price}'),
//                       subtitle: Text('quantity ${products[index].quantity}'),
//                       trailing: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               products.removeAt(index);
//                             });
//                           },
//                           icon: Icon(Icons.delete_forever)),
//                     ),
//                   );
//                 },
//               )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {
//                         value.addInvoice(Invoice(
//                             id: InvoiceApp.invoiceNo,
//                             name: cNameController.text,
//                             products: products));
//                         InvoiceApp.invoiceNo++;
//                         cNameController.clear();
//                         products = [];
//                         setState(() {});
//                       },
//                       child: Text('add invoice')),
//                   ElevatedButton(
//                       onPressed: () async {
//                         await Navigator.pushNamed(context, '/invoices_list');
//                         setState(() {});
//                       },
//                       child: Text('show all invoices')),
//                 ],
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart'; // استيراد حزمة Flutter لبناء واجهات المستخدم
import 'package:final_lab/invoice_model.dart'; // استيراد نموذج الفواتير (InvoiceModel)
import 'package:provider/provider.dart'; // استيراد حزمة Provider لإدارة الحالة
import 'details_page.dart'; // استيراد صفحة التفاصيل
import 'invoices_list.dart'; // استيراد صفحة عرض قائمة الفواتير
import 'invoice.dart'; // استيراد الكائن (Invoice) الذي يمثل الفاتورة
import 'loading.dart'; // استيراد صفحة التحميل
import 'product.dart'; // استيراد الكائن (Product) الذي يمثل المنتج

void main() {
  runApp(const MyApp()); // تشغيل التطبيق باستخدام عنصر MyApp كالجذر
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // تعريف منشئ (Constructor) للفئة مع مفتاح فريد

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        //  providerإنشاء
        //  لإدارة الحالة باستخدام 
        // InvoiceModel
        create: (context) => InvoiceModel(), // إنشاء كائن نموذج الفواتير
        builder: (context, child) => MaterialApp(
              // بناء التطبيق باستخدام MaterialApp
              initialRoute: '/loading', // تحديد صفحة البدء
              routes: {
                // تحديد مسارات التطبيق
                '/': (context) => InvoiceApp(), // الصفحة الرئيسية
                '/invoices_list': (context) =>
                    InvoicesList(), // صفحة قائمة الفواتير
                '/details_page': (context) => DetailsPage(), // صفحة التفاصيل
                '/loading': (context) => Loading(), // صفحة التحميل
              },
            ));
  }
}

// تعريف متحكمات النصوص لتلقي إدخالات المستخدم
TextEditingController cNameController = TextEditingController(); // اسم العميل
TextEditingController pNameController = TextEditingController(); // اسم المنتج
TextEditingController quantityController = TextEditingController(); // الكمية
TextEditingController priceController = TextEditingController(); // السعر

// قائمة أولية تحتوي على منتجات
List<Product> products = [
  Product(name: 'Mouse', quantity: 10, price: 20.3), // المنتج الأول
  Product(name: 'Ram', quantity: 5, price: 150.5), // المنتج الثاني
];

class InvoiceApp extends StatefulWidget {
  // فئة Stateful لتمثيل واجهة الفواتير
  const InvoiceApp({super.key}); // تعريف منشئ الفئة
  static int invoiceNo = 1; // رقم الفاتورة الابتدائي

  @override
  State<InvoiceApp> createState() => _InvoiceAppState(); // إنشاء الحالة
}

class _InvoiceAppState extends State<InvoiceApp> {
  @override
  Widget build(BuildContext context) {
    // تحديث رقم الفاتورة بناءً على البيانات الموجودة
    if (!context.read<InvoiceModel>().isEmpty()) {
      InvoiceApp.invoiceNo = context.read<InvoiceModel>().getLast().id + 1;
    } else {
      InvoiceApp.invoiceNo = 1; // إذا كانت القائمة فارغة، يكون رقم الفاتورة 1
    }

    return Consumer<InvoiceModel>(
      // استخدام Consumer للوصول إلى نموذج الفواتير
      builder: (context, value, child) {
        return Scaffold(
          // بناء واجهة التطبيق
          appBar: AppBar(
            // شريط التطبيق العلوي
            backgroundColor: Colors.blue, // اللون الأزرق
            title: Text(
                'Invoice# ${InvoiceApp.invoiceNo}'), // عرض رقم الفاتورة الحالي
          ),
          body: Column(
            // عمود يحتوي على محتويات الصفحة
            children: [
              SizedBox(height: 20), // مسافة بين العناصر
              TextField(
                // حقل إدخال لاسم العميل
                controller: cNameController, // ربط المتحكم بالحقل
                decoration:
                    InputDecoration(labelText: 'customer name'), // نص توضيحي
              ),
              SizedBox(height: 20), // مسافة بين العناصر
              Row(
                // صف يحتوي على عنوان وزر لإضافة منتج
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // توزيع العناصر بالتساوي
                children: [
                  Text('Products',
                      style: TextStyle(fontSize: 22)), // نص "منتجات"
                  ElevatedButton(
                      // زر لإضافة منتج جديد
                      onPressed: () {
                        showDialog(
                          // إظهار نافذة منبثقة
                          context: context,
                          builder: (context) => AlertDialog(
                            // نافذة منبثقة لإدخال معلومات المنتج
                            title: Text('Product Info'), // عنوان النافذة
                            content: SingleChildScrollView(
                              // لعرض العناصر داخل النافذة
                              child: Column(
                                children: [
                                  TextField(
                                    controller: pNameController, // اسم المنتج
                                    decoration:
                                        InputDecoration(labelText: 'name'),
                                  ),
                                  TextField(
                                    controller: quantityController, // الكمية
                                    decoration:
                                        InputDecoration(labelText: 'quantity'),
                                  ),
                                  TextField(
                                    controller: priceController, // السعر
                                    decoration:
                                        InputDecoration(labelText: 'price'),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              // أزرار الإجراءات
                              ElevatedButton(
                                  onPressed: () {
                                    try {
                                      // محاولة إضافة المنتج للقائمة
                                      setState(() {
                                        products.add(Product(
                                            name: pNameController.text,
                                            quantity: int.parse(
                                                quantityController.text),
                                            price: double.parse(
                                                priceController.text)));
                                      });
                                      pNameController.clear(); // مسح الحقول
                                      quantityController.clear();
                                      priceController.clear();
                                      Navigator.pop(context); // إغلاق النافذة
                                    } catch (e) {
                                      // في حالة حدوث خطأ
                                      SnackBar snack = SnackBar(
                                          content: Text(
                                              'please fill all fields correctly')); // رسالة خطأ
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack); // عرض الرسالة
                                    }
                                  },
                                  child: Text('add')), // زر "إضافة"
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق النافذة
                                  },
                                  child: Text('cancel')), // زر "إلغاء"
                            ],
                          ),
                        );
                      },
                      child: Text('add product')), // نص الزر "إضافة منتج"
                ],
              ),
              Expanded(
                  // قائمة عرض المنتجات
                  child: ListView.builder(
                itemCount: products.length, // عدد المنتجات
                itemBuilder: (context, index) {
                  // بناء كل عنصر في القائمة
                  return Padding(
                    padding: const EdgeInsets.all(8.0), // حافة
                    child: ListTile(
                      tileColor: Colors.blue[300], // لون العنصر
                      leading: Text(
                        // اسم المنتج
                        products[index].name,
                        style: TextStyle(fontSize: 22),
                      ),
                      title: Text('price ${products[index].price}'), // السعر
                      subtitle: Text(
                          'quantity ${products[index].quantity}'), // الكمية
                      trailing: IconButton(
                          // زر الحذف
                          onPressed: () {
                            setState(() {
                              products.removeAt(index); // إزالة المنتج
                            });
                          },
                          icon: Icon(Icons.delete_forever)), // أيقونة الحذف
                    ),
                  );
                },
              )),
              Row(
                // أزرار التحكم
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        value.addInvoice(Invoice(
                            // إضافة فاتورة جديدة
                            id: InvoiceApp.invoiceNo,
                            name: cNameController.text,
                            products: products));
                        InvoiceApp.invoiceNo++; // تحديث رقم الفاتورة
                        cNameController.clear(); // مسح الحقول
                        products = []; // تفريغ قائمة المنتجات
                        setState(() {});
                      },
                      child: Text('add invoice')), // نص الزر "إضافة فاتورة"
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context,
                            '/invoices_list'); // الانتقال لصفحة قائمة الفواتير
                        setState(() {}); // تحديث الواجهة
                      },
                      child: Text(
                          'show all invoices')), // نص الزر "عرض كل الفواتير"
                ],
              ),
              SizedBox(
                height: 50, // مسافة فارغة في الأسفل
              ),
            ],
          ),
        );
      },
    );
  }
}
