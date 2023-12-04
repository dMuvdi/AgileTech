import 'package:agile_tech/models/equipment.dart';
import 'package:agile_tech/models/user.dart';

class Report {
  final String? id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String code;
  final String description;
  final Equipment? equipment;
  final User? user;

  Report({
    this.id, 
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.code,
    required this.description,
    this.equipment,
    this.user
  });
  
  static Report fromMap({required Map map}) => Report(
    id: map['id'],
    createdAt: DateTime.parse(map['createdAt']).toLocal(),
    code: map['code'],
    description: map['description'],
  );
}