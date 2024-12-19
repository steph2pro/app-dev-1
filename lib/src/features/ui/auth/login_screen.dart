import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/core/i18n/l10n.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/features/logic/providers/auth_provider.dart';
import 'package:crush_app/src/features/ui/video_chat/video_call_test_screen.dart';
import 'package:crush_app/src/shared/components/atoms/dividers/labeled_divider.dart';
import 'package:crush_app/src/shared/components/buttons/button.dart';
import 'package:crush_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:crush_app/src/shared/components/dialogs/feedback.dart';
import 'package:crush_app/src/shared/components/forms/input.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await LocalStorage().remove('user');
      var user =
          await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);

      if (user != null && user.accessToken != null) {
        goTo(context, '/home', popAll: true);
        // context.router.push(const DashboardHomeRoute());
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Affichage du dialogue de chargement en fonction de l'état
        if (authProvider.isLoadingLogin) {
          // Utilisez addPostFrameCallback ici
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingDialog.show(context: context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingDialog.hide(context: context);
          });
        }

        // Affichage des erreurs si elles existent
        if (authProvider.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingDialog.hide(context: context);
            FeedbackOverlay().show(
              context,
              authProvider.errorMessage ?? "",
              type: FeedbackType.error,
            );
          });
        }

        // Gestion des succès (si un utilisateur est connecté avec succès)
        if (authProvider.isSuccessLogIn) {
          final user = authProvider.user!;
          // print("data login res " + user.accessToken);

          //Sauvegarder l'utilisateur localement
          LocalStorage().setObject('user', user.toJson()).then((_) {
            LoadingDialog.hide(context: context);
            // context.router.push(const DashboardHomeRoute());
            goTo(context, "/home");
          });
        }

        // Retour du widget enfant
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                const Gap.vertical(height: Dimens.tripleSpacing),
                Text(
                  I18n.of(context).login_title,
                  style: context.textTheme.titleLarge,
                ),
                const Gap.vertical(height: Dimens.minSpacing),
                Text(I18n.of(context).login_subtitle,
                    style: context.textTheme.bodyMedium),
                const Gap.vertical(height: Dimens.doubleSpacing),
                AutofillGroup(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Numéro de téléphone',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'CM',
                          controller: _phoneController,
                          onChanged: (phone) {
                            log("phone.completeNumber: " +
                                phone.completeNumber);
                            context
                                .read<AuthProvider>()
                                .onChangeValue('phone', phone.completeNumber);
                          },
                        ),
                        const Gap.vertical(height: Dimens.spacing),
                        Input(
                          autofillHints: const [AutofillHints.password],
                          controller: _passwordController,
                          isPassword: !_isPasswordVisible,
                          labelText: I18n.of(context).login_passwordLabel,
                          hintText: I18n.of(context).login_passwordHint,
                          onChanged: (value) => context
                              .read<AuthProvider>()
                              .onChangeValue('password', value),
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                                () => _isPasswordVisible = !_isPasswordVisible),
                            icon: Icon(
                              _isPasswordVisible
                                  ? IconsaxPlusBroken.eye
                                  : IconsaxPlusBroken.eye_slash,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          onSubmitted: (_) => _onLogin(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap.vertical(height: Dimens.spacing),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(I18n.of(context).login_forgotPasswordLabel),
                  ),
                ),
                const Gap.vertical(height: Dimens.spacing),
                Button.primary(
                  height: 50,
                  title: I18n.of(context).login_submitBtnLabel,
                  onPressed: _onLogin,
                ),
                const Gap.vertical(height: Dimens.doubleSpacing),
                LabeledDivider(
                  label: I18n.of(context).or,
                ),
                const Gap.vertical(height: Dimens.doubleSpacing),
                Button.outline(
                  height: 50,
                  title: I18n.of(context).signup_title,
                  onPressed: () {
                    // _onSignup();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context)=>VideoCallTestScreen(callId:_passwordController.text)
                      )
                    );

                  },
                ),
                const Gap.vertical(height: Dimens.spacing),
                // Button.outline(
                //   height: 50,
                //   title: "test chat",
                //   onPressed: () {
                //     _onTest();
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onLogin() {
    context.read<AuthProvider>().login(context);
  }

  void _onSignup() {
    print('yess router');
    goTo(context, '/signup');
  }

  void _onTest() {
    print('yess router');
    // context.router.push(const TestChatRoute());
  }

  void _onLogin2() => context.read<AuthProvider>().login(context);
}
