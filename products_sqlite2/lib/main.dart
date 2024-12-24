import 'package:flutter/material.dart';
import 'package:sqlite_example/database_provider.dart';
import 'package:sqlite_example/product_details.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int updatedId= 1;
  List<Product> products = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'delete all',
        onPressed: () {
          DatabaseProvider.db.removeAll();
          setState(() {

          });
        },
        child: Icon(Icons.delete_sweep),
      ),
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Product information',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 2.0),
          ),

          Divider(height: 10.0,color: Colors.black,),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Product Name',
            ),
          ),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
            ),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Price',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      quantityController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    const snackBar = SnackBar(content: Text('Please fill all fields'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  DatabaseProvider.db.insertProduct(
                    Product(
                        productName: nameController.text,
                        quantity: int.parse(quantityController.text),
                        price: double.parse(priceController.text)
                    )
                  ).then((value){
                    var text = 'product added successfully';
                    if(value == 0) {
                      text = 'nothing added';
                    }
                    var snackBar = SnackBar(content: Text(text));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  nameController.clear();
                  priceController.clear();
                  quantityController.clear();
                  setState(() {

                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add Product'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      quantityController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    const snackBar = SnackBar(content: Text('Please fill all fields'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  DatabaseProvider.db.updateProduct(
                      Product(
                        id: updatedId,
                        productName: nameController.text,
                        quantity: int.parse(quantityController.text),
                        price: double.parse(priceController.text)
                  )
                  ).then((value) {
                    var text = 'product updated successfully';
                    if(value == 0) {
                      text = 'nothing updated';
                    }
                    var snackBar = SnackBar(content: Text(text));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  nameController.clear();
                  priceController.clear();
                  quantityController.clear();
                  setState(() {

                  });
                },
                icon: Icon(Icons.update),
                label: Text('Update Product'),
              ),
            ],
          ),
          Text(
            'Your Products:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                letterSpacing: 2.0),
          ),
          FutureBuilder(
            future: DatabaseProvider.db.getProducts(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<Product>?  products = snapshot.data;
                  return Expanded(
                      child: ListView.builder(
                        itemCount: products?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(index),));
                                },
                                onLongPress: () {
                                  updatedId = products![index].id!;
                                  nameController.text = products![index].productName;
                                  priceController.text = products![index].price.toString();
                                  quantityController.text = products![index].quantity.toString();

                                },
                                tileColor: Colors.blue,
                                leading: Text(products![index].productName),
                                title: Text('Price: ${products![index].price}'),
                                subtitle: Text('quantity: ${products![index].quantity}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    DatabaseProvider.db.removeProduct(products![index].id!);
                                    setState(() {

                                    });
                                  },
                                ),
                              ),
                            );
                          },
                      ),
                  );
                } else if(snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }else
                  return CircularProgressIndicator();
              },
          ),
        ],
      ),
    );
  }
}
