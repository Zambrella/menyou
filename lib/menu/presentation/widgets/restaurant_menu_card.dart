import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menus_page_controller.dart';
import 'package:men_you/routing/app_router.dart';
import 'package:men_you/theme/theme_extensions.dart';

class RestaurantMenuCard extends ConsumerStatefulWidget {
  const RestaurantMenuCard({required this.menu, super.key});

  final RestaurantMenu menu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestaurantMenuCardState();
}

class _RestaurantMenuCardState extends ConsumerState<RestaurantMenuCard> {
  RestaurantMenu get menu => widget.menu;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        key: ValueKey(menu.id),
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.33,
          children: [
            SlidableAction(
              onPressed: (_) async {
                await ref.read(menusPageControllerProvider.notifier).removeMenu(menu.id);
              },
              backgroundColor: context.theme.colorScheme.error,
              foregroundColor: context.theme.colorScheme.onError,
              spacing: 0,
              icon: context.theme.brightness == Brightness.light ? Icons.delete : Icons.delete_outline,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            context.goNamed(
              AppRoute.menu.name,
              pathParameters: {'menuId': menu.id},
              extra: menu,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  menu.name ?? 'New Menu',
                  style: context.theme.textTheme.headlineSmall!.copyWith(color: context.theme.colorScheme.onSurface),
                ),
                Text(
                  '${menu.menuItems?.length ?? 0} items on the menu',
                  style: context.theme.textTheme.bodyMedium!.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Created on ${DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(menu.createdAt)}',
                  style: context.theme.textTheme.bodyMedium!.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
