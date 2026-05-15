import 'package:vanashree_ngo_application/features/auth/domain/entities/login_entitties.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, bool>> login (LoginEntity user);
}