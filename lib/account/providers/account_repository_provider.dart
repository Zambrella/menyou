import 'package:men_you/account/domain/account_repository.abs.dart';
import 'package:men_you/account/repository/firebase_account_repository.dart';
import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AccountRepository accountRepository(AccountRepositoryRef ref) {
  return FirebaseAccountRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(firestoreProvider),
  );
}
