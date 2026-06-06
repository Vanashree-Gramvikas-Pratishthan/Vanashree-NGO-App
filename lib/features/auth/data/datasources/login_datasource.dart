import '../../domain/entities/login_entitties.dart';

abstract interface class IAuthLocalDataSource {
  Future<bool> saveUser(LoginEntity user);
  Future<LoginEntity?> getUser(String email);
}

// abstract interface class IAuthRemoteDatasource {
//   Future<AuthApiModel> registerUser(AuthApiModel user);
//   Future<AuthApiModel?> loginUser(String email, String password);
//   Future<AuthApiModel?> getuserById(String authId);
//   Future<bool> sendPasswordResetEmail(String email);
//   Future<AuthApiModel?> googleLogin(String idToken);
// }