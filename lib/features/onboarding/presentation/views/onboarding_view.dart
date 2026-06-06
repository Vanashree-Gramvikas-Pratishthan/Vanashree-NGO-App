import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vanashree_ngo_application/config/router/route_names/route_names.dart';
import 'package:vanashree_ngo_application/features/app_start/presentation/providers/app_start_view_model.dart';
import 'package:vanashree_ngo_application/features/onboarding/presentation/providers/onboarding_page_provider.dart';

class OnboardingView extends HookConsumerWidget {
  const OnboardingView({super.key});

  final List<_OnboardingScreen> _screens = const [
    _OnboardingScreen(
      icon: Icons.spa,
      title: 'Plant Hope',
      description:
          'Start by planting seeds of support for every cause your NGO cares about.',
    ),
    _OnboardingScreen(
      icon: Icons.water_drop,
      title: 'Grow Community',
      description:
          'Engage volunteers, donors, and partners with simple progress tracking.',
    ),
    _OnboardingScreen(
      icon: Icons.park,
      title: 'Harvest Change',
      description:
          'Watch your organization blossom as every effort becomes meaningful action.',
    ),
  ];

  void _goToNextPage(
    BuildContext context,
    WidgetRef ref,
    PageController pageController,
    int currentPage,
  ) {
    if (currentPage < _screens.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    _completeOnboarding(context, ref);
  }

  Future<void> _completeOnboarding(BuildContext context, WidgetRef ref) async {
    await ref.read(appStartViewModelProvider.notifier).completeOnboarding();
    if (!context.mounted) return;
    context.go(RouteNames.auth.login);
  }

  void _skipOnboarding(BuildContext context, WidgetRef ref) {
    _completeOnboarding(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pageController = usePageController();
    final currentPage = ref.watch(onboardingPageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          TextButton(
            onPressed: () => _skipOnboarding(context, ref),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: _screens.length,
                onPageChanged: (index) =>
                    ref.read(onboardingPageProvider.notifier).setPage(index),
                itemBuilder: (context, index) {
                  final screen = _screens[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: theme.colorScheme.primary.withValues(
                            alpha: 0.12,
                          ),
                          child: Icon(
                            screen.icon,
                            size: 56,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          screen.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          screen.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.75,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _screens.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: currentPage == index ? 24 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withValues(
                                  alpha: 0.24,
                                ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _goToNextPage(
                        context,
                        ref,
                        pageController,
                        currentPage,
                      ),
                      child: Text(
                        currentPage == _screens.length - 1
                            ? 'Get Started'
                            : 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingScreen {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingScreen({
    required this.icon,
    required this.title,
    required this.description,
  });
}
