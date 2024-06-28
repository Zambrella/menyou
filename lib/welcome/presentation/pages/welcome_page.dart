import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/authentication/presentation/controllers/register_controller.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(registerControllerProvider, (prev, state) {
      state.when(
        data: (_) {},
        error: (e, st) {},
        loading: () {},
      );
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: ElevatedButton.icon(
                onPressed: ref.watch(registerControllerProvider).isLoading
                    ? null
                    : () {
                        ref.read(registerControllerProvider.notifier).register();
                      },
                icon: ref.watch(registerControllerProvider).isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : null,
                label: const Text('Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
