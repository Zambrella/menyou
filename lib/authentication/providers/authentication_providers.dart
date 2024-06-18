import 'package:auth_core/auth_core.dart';
import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_providers.g.dart';

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).getUser();
}

@Riverpod(keepAlive: true)
AppUser? currentUser(CurrentUserRef ref) {
  return ref.watch(authStateChangesProvider).value;
}
