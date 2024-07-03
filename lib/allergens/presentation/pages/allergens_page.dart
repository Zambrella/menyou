import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/allergens/presentation/controllers/allergens_page_controller.dart';
import 'package:men_you/allergens/repository/allergen_repository_provider.dart';
import 'package:men_you/allergens/utils/allergen_states_extension.dart';
import 'package:men_you/theme/theme_extensions.dart';

class AllergensPage extends ConsumerStatefulWidget {
  const AllergensPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllergensPageState();
}

class _AllergensPageState extends ConsumerState<AllergensPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allergens'),
      ),
      body: ref.watch(allergensPageControllerProvider).when(
            skipLoadingOnRefresh: false,
            data: (allergensAndStates) {
              // TODO: Animate the list
              return ListView.builder(
                itemCount: allergensAndStates.length,
                itemBuilder: (context, index) {
                  final allergen = allergensAndStates[index].$1;
                  final allergenState = allergensAndStates[index].$2;
                  return Card(
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
                                  const Icon(Icons.food_bank),
                                  const SizedBox(width: 4),
                                  Text(
                                    allergen.name,
                                    style: context.theme.textTheme.headlineSmall,
                                  ),
                                ],
                              ),
                              Text(allergen.description),
                            ],
                          ),
                          SizedBox(height: 8),
                          SegmentedButton<AllergenStates>(
                            selected: {allergenState},
                            onSelectionChanged: (allergenState) {},
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
                  );
                },
              );
            },
            error: (e, st) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('An error occurred'),
                    ElevatedButton(
                      onPressed: () {
                        // Invalidating "root" provider as the error could have come from any of the providers.
                        // This will cause all "subproviders" to be re-evaluated.
                        ref.invalidate(allergenRepositoryProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
