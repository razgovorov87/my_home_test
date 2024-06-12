import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import '../../dto/auth_credential_dto/auth_credential_dto.dart';
import '../../dto/user_dto/user_dto.dart';
import 'sp_config.dart';

@preResolve
@singleton
class SPSource with SPConfig {
  SPSource._(this._rxPrefs);

  final RxSharedPreferences _rxPrefs;

  late final BehaviorSubject<UserDto?> _currentUserSubject;

  @factoryMethod
  static Future<SPSource> create() async {
    final RxSharedPreferences rxPrefs = RxSharedPreferences(
      SharedPreferences.getInstance(),
      const RxSharedPreferencesEmptyLogger(),
    );
    final SPSource instance = SPSource._(rxPrefs);
    instance._init();
    return instance;
  }

  UserDto? get currentUser => _currentUserSubject.value;

  Stream<UserDto?> get currentUserStream => _currentUserSubject.distinct();

  Future<void> _init() async {
    await _initCurrentUser();
  }

  Future<void> _initCurrentUser() async {
    final UserDto? currentUser = await getCurrentUser();

    _currentUserSubject = BehaviorSubject<UserDto?>.seeded(currentUser);
    _currentUserSubject.addStream(getCurrentUserStream());
  }

  Future<void> setCurrentUser(UserDto user) async {
    await _rxPrefs.setString(currentUserKey, json.encode(user.toJson()));
  }

  Future<void> logout() async {
    await _rxPrefs.setString(currentUserKey, null);
  }

  Future<UserDto?> getCurrentUser() async {
    final String? str = await _rxPrefs.getString(currentUserKey);
    if (str == null) {
      return null;
    }

    final Map<String, dynamic> data = json.decode(str) as Map<String, dynamic>;
    return UserDto.fromJson(data);
  }

  Stream<UserDto?> getCurrentUserStream() => _rxPrefs.getStringStream(currentUserKey).map(
        (String? event) {
          if (event == null) {
            return null;
          } else {
            final Map<String, dynamic> data = json.decode(event) as Map<String, dynamic>;
            return UserDto.fromJson(data);
          }
        },
      );

  Future<void> setAuthCredential(AuthCredentialDto credential) async {
    await _rxPrefs.setString(authCredentialKey, json.encode(credential.toJson()));
  }

  Future<AuthCredentialDto?> getAuthCredentials() async {
    final String? str = await _rxPrefs.getString(authCredentialKey);
    if (str == null) {
      return null;
    }

    final Map<String, dynamic> data = json.decode(str) as Map<String, dynamic>;
    return AuthCredentialDto.fromJson(data);
  }

  Future<void> clear() => _rxPrefs.clear();
}
