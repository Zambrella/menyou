import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/allergens/presentation/controllers/allergens_page_controller.dart';
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
    for (var i = 0; i < allergensAndStates.length; i++) {
      final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          i / allergensAndStates.length,
          (i + 1.5) / allergensAndStates.length,
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
        return AnimatedBuilder(
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
                                // TODO: Update icon
                                const Icon(Icons.food_bank),
                                const SizedBox(width: 4),
                                Text(
                                  allergen.name,
                                  style: context.theme.textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 4 + 26),
                              ],
                            ),
                            Text(allergen.description),
                          ],
                        ),
                        SizedBox(height: 8),
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
