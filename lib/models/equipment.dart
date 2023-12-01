class Equipment {
  final String? id;
  final String name;
  final String description;
  final String category;
  final int stock;
  final String? imageUrl;

  Equipment({
    this.id, 
    required this.name,
    required this.description,
    required this.category,
    required this.stock,
    this.imageUrl,
  });
  
  static Equipment fromMap({required Map map}) => Equipment(
    id: map['id'],
    name: map['name'],
    description: map['description'],
    category: map['category'],
    stock: map['stock'],
    imageUrl: map['imageUrl'],
  );
}