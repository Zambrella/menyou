import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/pages/menu_item_chat_page.dart';
import 'package:men_you/menu/presentation/widgets/menu_item_allergens.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenuItemDetailsPage extends ConsumerStatefulWidget {
  const MenuItemDetailsPage({
    required this.menuItem,
    super.key,
  });

  final MenuItem menuItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuItemDetailsPageState();
}

class _MenuItemDetailsPageState extends ConsumerState<MenuItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surfaceContainer,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => MenuItemChatPage(menuItem: widget.menuItem as ProcessedMenuItem),
          ),
        ),
        label: const Text('Ask a question'),
        icon: const Icon(Icons.question_answer),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: context.theme.colorScheme.surfaceContainer,
          flexibleSpace: Image.network(
            'https://images.unsplash.com/photo-1512152272829-e3139592d56f?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.3),
          ),
          leading: IconButton(
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
            SizedBox(height: 4),
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
            SizedBox(height: 2),
            if (widget.menuItem.subtitle != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.menuItem.subtitle ?? '',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MenuItemAllergens(menuItem: widget.menuItem as ProcessedMenuItem),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ut ex et tellus varius pellentesque. Vivamus lacinia justo nec mi posuere, ut consequat nulla hendrerit. Suspendisse pretium faucibus urna non scelerisque. Nullam in maximus lectus. Ut vitae vulputate velit. In sollicitudin libero turpis, sit amet ornare risus interdum eu. Duis sodales in sem at sollicitudin. Curabitur scelerisque, massa in hendrerit aliquam, ligula leo molestie lorem, blandit luctus tellus nunc et tortor. Integer vel maximus nunc. Suspendisse potenti. Duis vel lacus leo. Curabitur sit amet enim pharetra, elementum neque et, sollicitudin dolor.
            
            Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Ut pharetra dignissim accumsan. Etiam sit amet ipsum non ex condimentum convallis. Etiam commodo sed enim quis tempus. Nulla congue sapien arcu, at accumsan lorem egestas et. Maecenas tincidunt scelerisque auctor. Quisque varius placerat sem dapibus dapibus. Vestibulum in egestas quam.
            
            Sed congue mattis dictum. Suspendisse iaculis accumsan enim eget vestibulum. Phasellus iaculis iaculis sapien a luctus. Quisque vitae odio iaculis, sollicitudin nibh eu, rhoncus massa. Quisque porta ullamcorper risus a viverra. Etiam non interdum massa. Integer vel libero leo. Praesent ut mauris accumsan, mattis neque et, ultrices ante. Donec id imperdiet tortor. Vivamus elementum, mi vehicula consequat vulputate, elit mauris aliquet diam, ac lobortis nisl lorem eget risus. Mauris venenatis auctor nulla, tempus consectetur ex. Vestibulum in quam placerat, sodales sem vel, blandit metus. Maecenas pulvinar tortor ac luctus commodo. Phasellus nisi enim, porttitor eget mi et, vestibulum suscipit dolor.''',
                style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurface),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16 + 64),
          ],
        ),
      ),
    );
  }
}
