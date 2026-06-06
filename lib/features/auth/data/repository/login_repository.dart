import 'package:vanashree_ngo_application/core/error/failures.dart';

import 'package:vanashree_ngo_application/core/utils/either.dart';

import 'package:vanashree_ngo_application/features/auth/domain/entities/login_entitties.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepository implements IAuthRepository{
  @override
  Future<Either<Failure, bool>> login(LoginEntity user) {
    throw UnimplementedError();
  }
}