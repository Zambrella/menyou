abstract class AccountRepository {
  const AccountRepository();

  /// Run code required to setup account. E.g. Create user document.
  Future<void> createAccount();

  /// Save whether the user does not want to see the AI warning again.
  Future<void> saveDoNotShowAiWarningAgain();

  /// Get whether the user does not want to see the AI warning again.
  /// `true` if the user does not want to see the AI warning again.
  Future<bool> getDoNotShowAiWarningAgain();
}
