class Report {
  final String? id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String code;
  final String description;
  final String? equipmentId;
  final String? userId;

  Report({
    this.id, 
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.code,
    required this.description,
    this.equipmentId,
    this.userId
  });
  
  static Report fromMap({required Map map}) => Report(
    id: map['id'],
    createdAt: DateTime.parse(map['createdAt']).toLocal(),
    code: map['code'],
    description: map['description'],
  );
}