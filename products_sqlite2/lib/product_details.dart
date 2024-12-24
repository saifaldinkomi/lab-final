import 'package:flutter/material.dart';
import 'package:sqlite_example/database_provider.dart';
import 'package:sqlite_example/product.dart';
class ProductInfo extends StatelessWidget {

  int index;
  ProductInfo(this.index, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product info'),
      ),
      body: FutureBuilder(
        future: DatabaseProvider.db.getProducts(),
        builder: (context, snapshot) {
          List<Product>? products = snapshot.data;
          if(snapshot.hasData) {
            return Text('Product id: ${products![index].id!}\n'
                'Product Name: ${products![index].productName}\n'
                'price: ${products![index].price}\n'
                'quantity: ${products![index].quantity}',
            style: TextStyle(fontSize: 25),);
          } else if(snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }

        },
      ),
    );
  }
}
