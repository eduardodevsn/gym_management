import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final DateTime? issuedAt;
  
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.issuedAt,
  });
  
  @override
  List<Object?> get props => [accessToken, refreshToken, expiresAt];
  
  bool get isValid => DateTime.now().isBefore(expiresAt);
  
  bool get needsRefresh {
    final fiveMinutesFromNow = DateTime.now().add(const Duration(minutes: 5));
    return !expiresAt.isAfter(fiveMinutesFromNow);
  }
  
  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    DateTime? issuedAt,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      issuedAt: issuedAt ?? this.issuedAt,
    );
  }
}