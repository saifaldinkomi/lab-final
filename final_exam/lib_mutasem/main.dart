import 'dart:io';
import 'package:flutter/material.dart';
import 'database_provider.dart';
import 'details_page.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'product.dart';

Future main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  databaseFactory = databaseFactoryFfi;
  runApp(const MyAppo());
}

TextEditingController cNameController = TextEditingController();
TextEditingController pNameController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController priceController = TextEditingController();

class MyAppo extends StatelessWidget {
  const MyAppo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseProvider.instance,
      builder: (context, child) {
        return const MaterialApp(
          home: ProductsPage(),
        );
      },
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products app'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Products: ',
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Product Info'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: pNameController,
                                decoration: InputDecoration(labelText: 'name'),
                              ),
                              TextField(
                                controller: quantityController,
                                decoration:
                                    InputDecoration(labelText: 'quantity'),
                              ),
                              TextField(
                                controller: priceController,
                                decoration: InputDecoration(labelText: 'price'),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                try {
                                  Product p = Product(
                                      name: pNameController.text,
                                      quantity:
                                          int.parse(quantityController.text),
                                      price:
                                          double.parse(priceController.text));
                                  DatabaseProvider.instance.add(p);
                                  pNameController.clear();
                                  quantityController.clear();
                                  priceController.clear();
                                  Navigator.pop(context);
                                } catch (e) {
                                  SnackBar snack = const SnackBar(
                                      content: Text(
                                          'please fill all feilds correctly'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                }
                              },
                              child: const Text('add')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('cancel')),
                        ],
                      ),
                    );
                  },
                  child: const Text('add product')),
            ],
          ),
          Consumer<DatabaseProvider>(
            builder: (context, value, child) {
              return FutureBuilder<List<Product>>(
                future: DatabaseProvider.instance.getAllProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> products = snapshot.data!;
                    if (products.isEmpty) {
                      return const Text(
                        'no products found',
                        style: TextStyle(fontSize: 25),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                DatabaseProvider.selectedProductedId =
                                    products[index].id!;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(),
                                    ));
                              },
                              onLongPress: () {
                                pNameController.text = products[index].name;
                                quantityController.text =
                                    '${products[index].quantity}';
                                priceController.text =
                                    '${products[index].price}';
                                // Product p;.
                                // DatabaseProvider.instance
                                //     .getProduct(products[index].id!)
                                //     .then((value) {
                                //   p = value;
                                //   pNameController.text = p.name;
                                //   quantityController.text = '${p.quantity}';
                                //   priceController.text = '${p.price}';
                                // });

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Product Info'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: pNameController,
                                            decoration: const InputDecoration(
                                                labelText: 'name'),
                                          ),
                                          TextField(
                                            controller: quantityController,
                                            decoration: const InputDecoration(
                                                labelText: 'quantity'),
                                          ),
                                          TextField(
                                            controller: priceController,
                                            decoration: const InputDecoration(
                                                labelText: 'price'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            try {
                                              Product p = Product(
                                                  id: products[index].id,
                                                  name: pNameController.text,
                                                  quantity: int.parse(
                                                      quantityController.text),
                                                  price: double.parse(
                                                      priceController.text));
                                              DatabaseProvider.instance
                                                  .update(p);
                                              pNameController.clear();
                                              quantityController.clear();
                                              priceController.clear();
                                              Navigator.pop(context);
                                            } catch (e) {
                                              SnackBar snack = const SnackBar(
                                                  content: Text(
                                                      'please fill all feilds correctly'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snack);
                                            }
                                          },
                                          child: const Text('update')),
                                      ElevatedButton(
                                          onPressed: () {
                                            pNameController.clear();
                                            quantityController.clear();
                                            priceController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('cancel')),
                                    ],
                                  ),
                                );
                              },
                              tileColor: Colors.blue,
                              leading: Text(products[index].name),
                              title:
                                  Text('quantity: ${products[index].quantity}'),
                              subtitle: Text('price: ${products[index].price}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    DatabaseProvider.instance
                                        .delete(products[index].id!)
                                        .then((value) {
                                      SnackBar snackBar = SnackBar(
                                          content:
                                              Text('$value row(s) deleted'));
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
                          );
                        },
                      ));
                    }
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else
                    return const CircularProgressIndicator();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
