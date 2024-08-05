import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/allergens/providers/user_allergies_and_intolerances_provider.dart';
import 'package:men_you/allergens/utils/allergen_icon_extension.dart';
import 'package:men_you/allergens/utils/allergen_name_extension.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenuItemAllergens extends ConsumerWidget {
  const MenuItemAllergens({required this.menuItem, super.key});

  final ProcessedMenuItem menuItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userAllergiesAndIntolerancesProvider).maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (data) {
            if (menuItem.allergens.isEmpty) {
              return const SizedBox.shrink();
            }
            return Wrap(
              spacing: context.theme.appSpacing.small,
              alignment: WrapAlignment.center,
              children: menuItem.allergens
                  .map((e) => e.toAllergen())
                  .map(
                    (allergen) {
                      final isAllergic = data[AllergenStates.allergic]!.contains(allergen);
                      final isIntolerant = data[AllergenStates.intolerant]!.contains(allergen);
                      final color = isAllergic
                          ? Colors.red.harmonizeWith(context.theme.colorScheme.secondaryContainer)
                          : isIntolerant
                              ? Colors.orange.harmonizeWith(context.theme.colorScheme.secondaryContainer)
                              : context.theme.colorScheme.secondaryContainer;
                      return Semantics(
                        label: allergen.name +
                            (isAllergic
                                ? ' (allergic)'
                                : isIntolerant
                                    ? ' (intolerant)'
                                    : ''),
                        child: Chip(
                          backgroundColor: color,
                          side: BorderSide(
                            color: HSLColor.fromColor(color).withLightness(0.3).toColor(),
                          ),
                          label: Text(
                            allergen.name,
                            style: context.theme.textTheme.bodySmall?.copyWith(
                              fontWeight: isAllergic || isIntolerant ? FontWeight.bold : FontWeight.normal,
                              color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                            ),
                          ),
                          avatar: SvgPicture.asset(
                            semanticsLabel: 'Icon of ${allergen.name}',
                            allergen.svgIcon,
                            height: 24 *
                                MediaQuery.textScalerOf(context).scale(context.theme.textTheme.headlineSmall!.fontSize!) /
                                context.theme.textTheme.headlineSmall!.fontSize!,
                          ),
                        ),
                      );
                    },
                  )
                  .toList()
                  .animate(interval: (500 / menuItem.allergens.length).ms)
                  .fade(duration: 300.ms),
            );
          },
        );
  }
}
