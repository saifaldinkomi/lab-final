import 'package:database/database_provider.dart';
import 'package:database/details_page.dart';
import 'package:database/product.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

TextEditingController productControllerName = TextEditingController();
TextEditingController productControllerPrice = TextEditingController();
TextEditingController productControllerQuintity = TextEditingController();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int updateProduct = 1;
  _showDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Product info:",
          style: TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: productControllerName,
                decoration: InputDecoration(
                  label: Text("Product Name"),
                  hintText: "Enter Product Name",
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: productControllerQuintity,
                decoration: InputDecoration(
                  label: Text("Product Quintity"),
                  hintText: "Enter Product Quintity",
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: productControllerPrice,
                decoration: InputDecoration(
                  label: Text("Product Price"),
                  hintText: "Enter Product Price",
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (type == "add") {
                  Product p = Product(
                    name: productControllerName.text,
                    quintity: int.parse(productControllerQuintity.text),
                    price: double.parse(productControllerPrice.text),
                  );
                  DatabaseProvider.db.insertProduct(p).then((value) {
                    SnackBar snackBar = SnackBar(
                      content: Text("${p.name} added at rowId $value"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                } else {
                  DatabaseProvider.db
                      .getProduct(updateProduct)
                      .then((value) => {
                            productControllerName.text = value.name,
                            productControllerQuintity.text =
                                value.quintity.toString(),
                            productControllerPrice.text =
                                value.quintity.toString(),
                          });
                  Product p = Product(
                    id: updateProduct,
                    name: productControllerName.text,
                    quintity: int.parse(productControllerQuintity.text),
                    price: double.parse(productControllerPrice.text),
                  );
                  DatabaseProvider.db.updateProduct(p).then((value) {
                    SnackBar snackBar = SnackBar(
                      content: Text("${p.name} updated at rowId $value"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }
                productControllerName.clear();
                productControllerQuintity.clear();
                productControllerPrice.clear();
                setState(() {});
                Navigator.of(context).pop();
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text(type == "add" ? "Add" : "update")),
          ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text("cansle"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products app'),
        // backgroundColor: Color(Colors.pinkAccent),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Products:",
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                  onPressed: () {
                    _showDialog(context, "add");
                  },
                  child: Text("add products")),
            ],
          ),
          FutureBuilder(
              future: DatabaseProvider.db.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product>? products = snapshot.data;
                  if (products!.isEmpty) {
                    return Text(
                      "No Products found",
                      style: TextStyle(fontSize: 24),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsPage(products[index].id!)));
                              },
                              onLongPress: () {
                                updateProduct = products[index].id!;
                                _showDialog(context, "update");
                              },
                              tileColor: Colors.blue,
                              leading: Text(products[index].name,
                                  style: TextStyle(fontSize: 24)),
                              title:
                                  Text("quintity:${products[index].quintity}"),
                              subtitle: Text("price:${products[index].price}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    DatabaseProvider.db
                                        .removeProduct(products[index])
                                        .then((value) {
                                      if (value != 0) {
                                        SnackBar snackBar = SnackBar(
                                          content: Text(
                                              "${products[index].name} deleted "),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.delete)));
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 24),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_sweep),
        tooltip: 'delete all products',
        onPressed: () {
          DatabaseProvider.db.removeall().then((value) {
            SnackBar snackpar = SnackBar(content: Text("$value products deleted"));
            ScaffoldMessenger.of(context).showSnackBar(snackpar);
          });
        },
      ),
    );
  }
}
