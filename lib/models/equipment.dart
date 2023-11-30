import 'package:agile_tech/models/report.dart';

class Equipment {
  final String? id;
  final String name;
  final String description;
  final String category;
  final double stock;
  final String? imageUrl;
  final List<Report> reports;

  Equipment({
    this.id, 
    required this.name,
    required this.description,
    required this.category,
    required this.stock,
    this.imageUrl,
    required this.reports
  });
  
  static Equipment fromMap({required Map map}) => Equipment(
    id: map['id'],
    name: map['name'],
    description: map['description'],
    category: map['category'],
    stock: map['stock'],
    imageUrl: map['imageUrl'],
    reports: map['reports'].map((report) => Report.fromMap(map: report)).toList()
  );
}