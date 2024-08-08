import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/authentication/presentation/controllers/register_controller.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:men_you/theme/common_theme.dart';
import 'package:men_you/theme/dark_theme.dart';
import 'package:men_you/theme/theme_extensions.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    unawaited(_controller.repeat());
    unawaited(ref.read(registerControllerProvider.notifier).register());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(registerControllerProvider, (prev, state) {
      state.when(
        data: (_) {},
        error: (e, st) {},
        loading: () {},
      );
    });

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    final l10n = AppLocalizations.of(context);
    return Theme(
      data: darkTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Image(
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    image: const AssetImage('assets/images/welcome-page-background.jpg'),
                    color: Colors.white.withOpacity(0.65),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, _) {
                                    return AnimatedOpacity(
                                      duration: const Duration(milliseconds: 250),
                                      opacity: _controller.isAnimating ? 1 : 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: kAiColors,
                                            stops: List.generate(kAiColors.length, (index) => index / (kAiColors.length - 1)),
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            transform: GradientRotation(_animation.value * 2 * pi),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned.fill(
                                child: ClipPath(
                                  clipper: CircleClipper(),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(color: Colors.transparent),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/men-you-logo-no-padding.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate(delay: 250.ms)
                          .fadeIn(duration: const Duration(milliseconds: 350))
                          .rotate(begin: -0.5, end: 0, duration: const Duration(milliseconds: 750))
                          .slideX(),
                      const Spacer(flex: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              l10n.welcomeHeaderPart1,
                              style: context.theme.textTheme.headlineLarge?.copyWith(
                                color: context.theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              l10n.welcomeHeaderPart2,
                              style: context.theme.textTheme.headlineLarge?.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1300.ms, delay: 500.ms),
                          ],
                        ).animate(delay: 1000.ms).fadeIn(),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.welcomeSubheader,
                          style: context.theme.textTheme.titleLarge?.copyWith(
                            color: context.theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ).animate(delay: 1500.ms).fadeIn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: ref.watch(registerControllerProvider).isLoading
                                ? context.theme.colorScheme.onSurface.withOpacity(0.5)
                                : context.theme.colorScheme.onSurface,
                            backgroundColor: primaryColor,
                            textStyle: context.theme.textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.all(8),
                          ),
                          onPressed: ref.watch(registerControllerProvider).isLoading
                              ? null
                              : () async {
                                  await submit();
                                },
                          child: Text(l10n.welcomeCTA),
                        ),
                      ).animate(delay: 2000.ms).fadeIn().moveY(begin: 50, end: 0, curve: Curves.easeIn),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final smallestSide = size.shortestSide;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: smallestSide / 2);
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
