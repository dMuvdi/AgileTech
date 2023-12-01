class User {
  final String? id;
  final String? email;
  final String? password;
  final String name;
  final String lastName;
  final String role;

  User({
    this.id, 
    this.email,
    this.password,
    required this.name, 
    required this.lastName,  
    required this.role
  });
  
  static User fromMap({required Map map}) => User(
    id: map['id'],
    name: map['name'], 
    lastName: map['lastName'],
    role: map['role']
  );
}