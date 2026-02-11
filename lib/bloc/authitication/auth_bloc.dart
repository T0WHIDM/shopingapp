import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/repository/authentication_repository.dart';
import 'package:flutter_shop_sample/bloc/authitication/auth_event.dart';
import 'package:flutter_shop_sample/bloc/authitication/auth_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _repository = locator.get();

  AuthBloc() : super(AuthInitateState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.userName, event.password);
      emit(AuthResponseState(response));
    });

    on<AuthRegisterRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.register(
        event.userName,
        event.password,
        event.passwordConfirm,
      );
      emit(AuthResponseState(response));
    });
  }
}
