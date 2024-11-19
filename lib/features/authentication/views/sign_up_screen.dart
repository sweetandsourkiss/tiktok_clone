import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/theme_config/theme_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/views/username_screen.dart';
import 'package:tiktok_clone/features/authentication/views/login_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeURL = "/";
  static const routeName = 'signUp';

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LogInScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    /* Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(
          seconds: 1,
        ),
        reverseTransitionDuration: const Duration(
          seconds: 1,
        ),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UsernameScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final opacityAnimation = Tween(
            begin: 0.5,
            end: 1.0,
          ).animate(animation);
          return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: child,
              ));
        },
      ),
    ); */
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle('TikTok'),
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(2),
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: AuthButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.user,
                        ),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: () => ref
                          .read(socialAuthProvider.notifier)
                          .githubSignIn(context),
                      child: const AuthButton(
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                        ),
                        text: 'Continue with Github',
                      ),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: AuthButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.user,
                              ),
                              text: S.of(context).emailPasswordButton,
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => ref
                                .read(socialAuthProvider.notifier)
                                .githubSignIn(context),
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.github,
                              ),
                              text: 'Continue with Github',
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(0),
            shadowColor: Colors.black,
            color: darkModeConfig.value ? null : Colors.grey.shade50,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn('female'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
