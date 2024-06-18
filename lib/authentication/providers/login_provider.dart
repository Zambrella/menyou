import 'package:men_you/app_dependencies.dart';
import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@Riverpod(keepAlive: false)
FutureOr<void> login(LoginRef ref, String userId) async {
  await ref.read(purchasesRepositoryProvider).setUserId(userId);
  await ref.read(errorLoggingRepositoryProvider).setUserId(userId);
  await ref.read(analyticsRepositoryProvider).setUserId(userId);
}
