import 'package:equatable/equatable.dart';
import 'package:vanashree_ngo_application/features/auth/domain/entities/login_entitties.dart';

enum LoginStatus {
  intial,
  loading,
  authenticated,
  unauthenticated,
  error
}

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginEntity? loginEntity;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.intial,
    this.loginEntity,
    this.errorMessage
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginEntity? loginEntity,
    String? errorMessage
  }) {
    return LoginState(
      status: status ?? this.status,
      loginEntity: loginEntity ??  this.loginEntity,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, loginEntity, errorMessage];
}