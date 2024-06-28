import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_controller.g.dart';

@riverpod
class LogoutController extends _$LogoutController {
  @override
  FutureOr<void> build() async {
    return null;
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      final _ = await ref.watch(authRepositoryProvider).logOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
