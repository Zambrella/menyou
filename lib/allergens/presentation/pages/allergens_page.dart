import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/allergens/presentation/controllers/allergens_page_controller.dart';
import 'package:men_you/allergens/presentation/widgets/allergens_list.dart';
import 'package:men_you/allergens/repository/allergen_repository_provider.dart';

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
              return AllergensList(allergensAndStates: allergensAndStates);
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
