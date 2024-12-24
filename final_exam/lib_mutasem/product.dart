// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int? id;
  String name;
  int quantity;
  double price;
  Product({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
    );
  }

  @override
  String toString() {
    return 'id: $id\nname: $name\nquantity: $quantity\nprice: $price';
  }
}
