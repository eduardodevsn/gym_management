import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_management/feature/auth/domain/entities/auth_token.dart';

abstract class AuthLocalDataSource {
  Future<void> setRememberMe(bool value);
  Future<bool> getRememberMe();
  Future<void> cacheToken(AuthToken token);
  Future<AuthToken?> getCachedToken();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  const AuthLocalDataSourceImpl({required this.secureStorage, required Object sharedPreferences});

  static const _keyRememberMe = 'remember_me';
  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyExpiresAt = 'expires_at';

  @override
  Future<void> setRememberMe(bool value) =>
      secureStorage.write(key: _keyRememberMe, value: value.toString());

  @override
  Future<bool> getRememberMe() async {
    final value = await secureStorage.read(key: _keyRememberMe);
    return value == 'true';
  }

  @override
  Future<void> cacheToken(AuthToken token) async {
    await Future.wait([
      secureStorage.write(key: _keyAccessToken, value: token.accessToken),
      secureStorage.write(key: _keyRefreshToken, value: token.refreshToken),
      secureStorage.write(key: _keyExpiresAt, value: token.expiresAt.toIso8601String()),
    ]);
  }

  @override
  Future<AuthToken?> getCachedToken() async {
    final access = await secureStorage.read(key: _keyAccessToken);
    final refresh = await secureStorage.read(key: _keyRefreshToken);
    final expiresStr = await secureStorage.read(key: _keyExpiresAt);
    if (access == null || refresh == null || expiresStr == null) return null;
    return AuthToken(
      accessToken: access,
      refreshToken: refresh,
      expiresAt: DateTime.parse(expiresStr),
    );
  }

  @override
  Future<void> clearCache() => secureStorage.deleteAll();
}
