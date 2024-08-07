import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:men_you/account/providers/account_repository_provider.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/repository/menu_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_setup.g.dart';

@riverpod
FutureOr<void> accountSetup(AccountSetupRef ref) async {
  // Setup collection in database
  await ref.read(accountRepositoryProvider).createAccount();

  // Save default menu
  final data = await rootBundle.loadString('assets/data/default_menu.json');
  final json = jsonDecode(data) as Map<String, dynamic>;
  final defaultMenu = RestaurantMenu.fromJson(json);
  await ref.read(menuRepositoryProvider).addMenu(defaultMenu);
  ref.invalidate(menuRepositoryProvider);
  return;
}
