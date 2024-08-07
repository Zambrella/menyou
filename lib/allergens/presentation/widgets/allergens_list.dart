import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/allergens/presentation/controllers/allergens_page_controller.dart';
import 'package:men_you/allergens/utils/allergen_icon_extension.dart';
import 'package:men_you/allergens/utils/allergen_name_extension.dart';
import 'package:men_you/allergens/utils/allergen_states_extension.dart';
import 'package:men_you/theme/theme_extensions.dart';

class AllergensList extends ConsumerStatefulWidget {
  const AllergensList({required this.allergensAndStates, super.key});

  final List<(Allergen, AllergenStates)> allergensAndStates;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllergensListState();
}

class _AllergensListState extends ConsumerState<AllergensList> with SingleTickerProviderStateMixin {
  List<(Allergen, AllergenStates)> get allergensAndStates => widget.allergensAndStates;

  static const _animationDuration = Duration(milliseconds: 4000);

  late final AnimationController _animationController;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animations = [];
    const overlapFraction = 0.5;

    for (var i = 0; i < allergensAndStates.length; i++) {
      final start = (i * (1 - overlapFraction)) / allergensAndStates.length;
      final end = ((i + 1) * (1 - overlapFraction) + overlapFraction) / allergensAndStates.length;

      final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          start,
          end.clamp(0.0, 1.0), // Ensure the end value does not exceed 1.0
          curve: Curves.easeIn,
        ),
      );
      _animations.add(Tween<double>(begin: 0, end: 1).animate(curvedAnimation));
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allergensAndStates.length,
      itemBuilder: (context, index) {
        final allergen = allergensAndStates[index].$1;
        final allergenState = allergensAndStates[index].$2;
        final translatedAllergen = allergen.toLocale(context);
        return AnimatedBuilder(
          key: ValueKey(allergen.id),
          animation: _animations[index],
          builder: (context, _) {
            final animationValue = _animations[index].value;
            return Transform.translate(
              offset: Offset(0, -50 * (1 - animationValue)),
              child: Opacity(
                opacity: animationValue,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  semanticsLabel: translatedAllergen.name,
                                  allergen.svgIcon,
                                  height: 24 *
                                      MediaQuery.textScalerOf(context).scale(context.theme.textTheme.headlineSmall!.fontSize!) /
                                      context.theme.textTheme.headlineSmall!.fontSize!,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  translatedAllergen.name,
                                  style: context.theme.textTheme.headlineSmall?.copyWith(color: context.theme.colorScheme.onSurface),
                                ),
                                const SizedBox(width: 8 + 24),
                              ],
                            ),
                            Text(
                              translatedAllergen.description,
                              style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurface),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<AllergenStates>(
                          showSelectedIcon: false,
                          selected: {allergenState},
                          onSelectionChanged: (allergenStateSelected) async {
                            if (allergenStateSelected.first == AllergenStates.allergic) {
                              await ref.read(allergensPageControllerProvider.notifier).addAllergy(allergen);
                            } else if (allergenStateSelected.first == AllergenStates.intolerant) {
                              await ref.read(allergensPageControllerProvider.notifier).addIntolerance(allergen);
                            } else {
                              if (allergenState == AllergenStates.intolerant) {
                                await ref.read(allergensPageControllerProvider.notifier).removeIntolerance(allergen);
                              }
                              if (allergenState == AllergenStates.allergic) {
                                await ref.read(allergensPageControllerProvider.notifier).removeAllergy(allergen);
                              }
                            }
                          },
                          segments: AllergenStates.values
                              .map(
                                (allergenState) => ButtonSegment(
                                  value: allergenState,
                                  label: Text(allergenState.prettyPrint(context)),
                                ),
                              )
                              .toList(),
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
    );
  }
}
