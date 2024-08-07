import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/pages/menu_item_chat_page.dart';
import 'package:men_you/menu/presentation/widgets/menu_item_allergens.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenuItemDetailsPage extends ConsumerStatefulWidget {
  const MenuItemDetailsPage({
    required this.menuItem,
    super.key,
  }) : assert(menuItem is ProcessedMenuItem, 'Only processed menu items are supported');

  final MenuItem menuItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuItemDetailsPageState();
}

class _MenuItemDetailsPageState extends ConsumerState<MenuItemDetailsPage> {
  ProcessedMenuItem get menuItem => widget.menuItem as ProcessedMenuItem;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surfaceContainer,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => MenuItemChatPage(menuItem: menuItem),
          ),
        ),
        label: Text(l10n.askAQuestion),
        icon: const Icon(Icons.question_answer),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: context.theme.colorScheme.surfaceContainer,
          flexibleSpace: Image.network(
            semanticLabel: 'Image of ${widget.menuItem.title}',
            'https://images.unsplash.com/photo-1512152272829-e3139592d56f?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.3),
          ),
          leading: IconButton(
            tooltip: l10n.close,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.menuItem.title,
                style: context.theme.textTheme.headlineSmall?.copyWith(
                  color: context.theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 2),
            if (widget.menuItem.subtitle != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.menuItem.subtitle!,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MenuItemAllergens(menuItem: menuItem),
            ),
            const SizedBox(height: 6),
            ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  menuItem.description,
                  style: context.theme.textTheme.bodyLarge?.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 4),
            ],
            const SizedBox(height: 6),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16 + 64),
          ],
        ),
      ),
    );
  }
}
