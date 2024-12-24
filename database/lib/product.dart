// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int? id;
  String name;
  int quintity;
  double price;
  Product({
    this.id,
    required this.name,
    required this.quintity,
    required this.price,
  });
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
        id: data["id"],
        name: data["name"],
        quintity: data["quintity"],
        price: data["price"]);

  }
  Map <String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "quintity": quintity,
      "price": price
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, quintity: $quintity, price: $price)';
  }
}
