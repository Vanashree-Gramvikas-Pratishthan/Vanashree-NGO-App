// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_page_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingPage)
final onboardingPageProvider = OnboardingPageProvider._();

final class OnboardingPageProvider
    extends $NotifierProvider<OnboardingPage, int> {
  OnboardingPageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPageHash();

  @$internal
  @override
  OnboardingPage create() => OnboardingPage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$onboardingPageHash() => r'd320444531f5a8ecec3b290b56f0ba28d4fb6fcc';

abstract class _$OnboardingPage extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
