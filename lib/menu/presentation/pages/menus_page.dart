import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menus_page_controller.dart';
import 'package:men_you/routing/app_router.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenusPage extends ConsumerStatefulWidget {
  const MenusPage({super.key});

  @override
  ConsumerState<MenusPage> createState() => _MenusPageState();
}

class _MenusPageState extends ConsumerState<MenusPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menus'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final menu = RestaurantMenu.empty();
              context.goNamed(
                AppRoute.menu.name,
                pathParameters: {'menuId': menu.id},
                extra: menu,
              );
            },
          ),
        ],
      ),
      body: ref.watch(menusPageControllerProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (menus) {
              if (menus.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'No menus found',
                      style: context.theme.textTheme.headlineMedium?.copyWith(color: context.theme.colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Add a menu by tapping the + button',
                      style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  final menu = menus[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Dismissible(
                      background: ColoredBox(color: Colors.red),
                      onDismissed: (_) async {
                        await ref.read(menusPageControllerProvider.notifier).removeMenu(menu.id);
                      },
                      key: ValueKey(menu.id),
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
                                menu.name ?? 'Menu ${menu.id}',
                                style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.onSurface),
                              ),
                              Text(
                                '${menu.menuItems?.length ?? 0} items on the menu',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}
