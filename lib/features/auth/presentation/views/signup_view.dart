import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:searchable_dropdown_field/searchable_dropdown_field.dart';
import 'package:vanashree_ngo_application/core/common/components/app_textfield.dart';
import 'package:vanashree_ngo_application/core/common/components/primary_button.dart';
import 'package:vanashree_ngo_application/core/common/constants/sizedbox_constants.dart';

import '../../../../core/common/constants/app_images.dart';
import '../../../../core/common/constants/constants.dart';
import '../../../../core/common/constants/padding_constants.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/locator.dart';

class SignUpView extends HookWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final countryController = useTextEditingController();
    final stateController = useTextEditingController();
    final cityController = useTextEditingController();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final mobileController = useTextEditingController();
    final bioController = useTextEditingController();
    final pageController = usePageController(initialPage: 0);
    final currentPage = useState(0);

    final formKey1 = useMemoized(() => GlobalKey<FormState>());
    final formKey2 = useMemoized(() => GlobalKey<FormState>());
    final formKey3 = useMemoized(() => GlobalKey<FormState>());

    final progressValue = (currentPage.value + 1) / 3;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: currentPage.value == 0,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              title: Text(
                Constants.appName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                ),
              ),
              actions: [
                Text(
                  'STEP ${(currentPage.value + 1).toString().padLeft(2, '0')} / 03      ',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              pinned: true,
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${(progressValue * 100).toInt()}% complete',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progressValue),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: context.colorScheme.primary.withValues(
                          alpha: 0.3,
                        ),
                        minHeight: 15,
                        borderRadius: BorderRadius.circular(8),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colorScheme.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (page) {
                  currentPage.value = page;
                },
                children: [
                  _PersonalInfoSection(
                    formKey: formKey1,
                    nameController: nameController,
                    emailController: emailController,
                    mobileController: mobileController,
                    pageController: pageController,
                  ),
                  _AddressInfoSection(
                    formKey: formKey2,
                    countryController: countryController,
                    stateController: stateController,
                    cityController: cityController,
                    pageController: pageController,
                  ),
                  _BioSection(
                    formKey: formKey3,
                    bioController: bioController,
                    pageController: pageController,
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

class _PersonalInfoSection extends StatelessWidget {
  const _PersonalInfoSection({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.pageController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Paddings.kHorizontalPadding15,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacing.vertical(30),
            Text(
              context.l10n.sign_up1_title,
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacing.vertical(10),
            Text(
              context.l10n.sign_up1_description,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.full_name,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppTextField(
              controller: nameController,
              hintText: 'Enter your name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_enter_your_name;
                }
                return null;
              },
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.email_address,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppTextField(
              controller: emailController,
              hintText: 'nature@example.com',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_enter_your_email;
                }
                return null;
              },
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.mobile_number,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppTextField(
              controller: mobileController,
              hintText: '+1 (555) 000-0000',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_enter_your_mobile_number;
                }
                return null;
              },
            ),
            const Spacing.vertical(40),
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: Paddings.kPadding24,
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.plant),
                  const Spacing.horizontal(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.security_and_trust,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          context.l10n.security_and_trust_description,
                          softWrap: true,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacing.vertical(40),
            PrimaryButton(
              suffixIcon: Icons.arrow_forward,
              padding: Paddings.kVerticalPadding24,
              borderRadius: 32,
              shouldElevate: false,
              backgroundColor: context.colorScheme.primary,
              textColor: context.colorScheme.onPrimary,
              title: context.l10n.next_step,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  appLog.error('Form is invalid, please correct the errors');
                }
              },
            ),
            const Spacing.vertical(40),
          ],
        ),
      ),
    );
  }
}

class _AddressInfoSection extends StatelessWidget {
  const _AddressInfoSection({
    required this.formKey,
    required this.countryController,
    required this.stateController,
    required this.cityController,
    required this.pageController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Paddings.kHorizontalPadding15,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacing.vertical(30),
            Text(
              context.l10n.sign_up2_title,
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacing.vertical(10),
            Text(
              context.l10n.sign_up2_description,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.country,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SearchableDropdownTextField<String>(
              controller: countryController,
              items: ["Nepal", "India", "USA", "UK", "Germany", "France"],
              itemAsString: (item) => item,
              hintText: "Select Country",
              onSelected: (value) {
                appLog.error(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_select_a_country;
                }
                return null;
              },
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.state,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SearchableDropdownTextField<String>(
              controller: stateController,
              items: [
                "Bagmati",
                "Gandaki",
                "Lumbini",
                "Karnali",
                "Sudurpashchim",
              ],
              itemAsString: (item) => item,
              hintText: "Select State",
              onSelected: (value) {
                appLog.error(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_select_a_state;
                }
                return null;
              },
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.city,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SearchableDropdownTextField<String>(
              controller: cityController,
              items: [
                "Kathmandu",
                "Pokhara",
                "Lalitpur",
                "Biratnagar",
                "Birgunj",
              ],
              itemAsString: (item) => item,
              hintText: "Select City",
              onSelected: (value) {
                appLog.error(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_select_a_city;
                }
                return null;
              },
            ),
            const Spacing.vertical(40),
            Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: 0.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(AppImages.seedling, height: 200),
                ),
              ),
            ),
            const Spacing.vertical(50),
            PrimaryButton(
              shouldElevate: false,
              backgroundColor: context.colorScheme.primary,
              textColor: context.colorScheme.onPrimary,
              title: context.l10n.next_step,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  appLog.error('Form is invalid, please correct the errors');
                }
              },
            ),
            PrimaryButton(
              shouldElevate: false,
              backgroundColor: context.colorScheme.surfaceContainer,
              textColor: context.colorScheme.onSecondary,
              prefixIcon: Icons.arrow_back,
              title: context.l10n.back,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
            const Spacing.vertical(20),
          ],
        ),
      ),
    );
  }
}

class _BioSection extends StatelessWidget {
  const _BioSection({
    required this.formKey,
    required this.bioController,
    required this.pageController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController bioController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Paddings.kHorizontalPadding15,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacing.vertical(30),
            Text(
              context.l10n.sign_up3_title,
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacing.vertical(10),
            Text(
              context.l10n.sign_up3_description,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacing.vertical(20),
            Text(
              context.l10n.your_bio,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppTextField(
              controller: bioController,
              hintText: 'Tell us why you care about native seedlings...',
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.please_enter_your_bio;
                }
                return null;
              },
            ),
            const Spacing.vertical(50),
            PrimaryButton(
              shouldElevate: false,
              backgroundColor: context.colorScheme.surfaceContainer,
              textColor: context.colorScheme.onSecondary,
              title: context.l10n.back,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
            PrimaryButton(
              shouldElevate: false,
              backgroundColor: context.colorScheme.primary,
              textColor: context.colorScheme.onPrimary,
              title: context.l10n.complete_onboarding,
              suffixIcon: Icons.check_circle_outlined,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  appLog.info('Form is valid, submitting');
                } else {
                  appLog.error('Form is invalid, please correct the errors');
                }
              },
            ),
            const Spacing.vertical(20),
          ],
        ),
      ),
    );
  }
}
