// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:database/database_provider.dart';

class DetailsPage extends StatelessWidget {
  int id;
  DetailsPage(
    this.id, {
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: FutureBuilder(
          future: DatabaseProvider.db.getProduct(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString(),
                  style: TextStyle(fontSize: 26));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
