import 'package:flutter/material.dart';
import 'database_provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
      ),
      body: FutureBuilder(
        future: DatabaseProvider.instance
            .getProduct(DatabaseProvider.selectedProductedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data.toString(),
              style: const TextStyle(fontSize: 25),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
