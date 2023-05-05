import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'AuthFailure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      _InvalidEmailAndPasswordCombination;

  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.invaliEmail() = InvalidEmail;
}
