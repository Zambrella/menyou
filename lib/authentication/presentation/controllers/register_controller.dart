import 'dart:async';

import 'package:analytics_core/analytics_core.dart';
import 'package:men_you/account/service/account_setup.dart';
import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> register() async {
    state = const AsyncLoading();
    try {
      final _ = await ref.read(authRepositoryProvider).signUpAnonymously();
      await ref.read(accountSetupProvider.future);
      await ref.read(analyticsRepositoryProvider).logCustomEvent(
            RegisterCustomEvent(email: '1234@test.com'),
          );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

class RegisterCustomEvent extends CustomAnalyticsEvent {
  RegisterCustomEvent({required String email}) : super('register', parameters: {'email': email});
}
