import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;
  final UserRole role;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  
  const User({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
    this.role = UserRole.user,
    required this.createdAt,
    this.lastLoginAt,
  });
  
  @override
  List<Object?> get props => [id, email, name, role];
  
  bool get hasName => name != null && name!.isNotEmpty;
  bool get isCoach => role == UserRole.coach;
}

enum UserRole {
  user,
  coach,
  admin,
}