import 'package:agile_tech/models/equipment.dart';
import 'package:agile_tech/models/user.dart';

class Report {
  final String? id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final String code;
  final String description;
  final Equipment equipment;
  final User user;

  Report({
    this.id, 
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.code,
    required this.description,
    required this.equipment,
    required this.user
  });
  
  static Report fromMap({required Map map}) => Report(
    id: map['id'],
    createdAt: map['createdAt'],
    updatedAt: map['updatedAt'],
    deletedAt: map['deletedAt'],
    code: map['code'],
    description: map['description'],
    equipment: Equipment.fromMap(map: map['equipment']),
    user: User.fromMap(map: map['user'])
  );
}