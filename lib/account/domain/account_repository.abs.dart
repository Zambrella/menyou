abstract class AccountRepository {
  const AccountRepository();

  /// Run code required to setup account. E.g. Create user document.
  Future<void> createAccount();
}
