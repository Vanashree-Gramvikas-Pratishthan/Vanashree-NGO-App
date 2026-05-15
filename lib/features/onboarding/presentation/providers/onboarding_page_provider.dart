import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_page_provider.g.dart';

@riverpod
class OnboardingPage extends _$OnboardingPage {
  @override
  int build() {
    return 0;
  }

  void setPage(int index) {
    state = index;
  }
}
