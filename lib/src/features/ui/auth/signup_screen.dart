import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/core/i18n/l10n.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/features/logic/providers/auth_provider.dart';
import 'package:crush_app/src/shared/components/atoms/dividers/labeled_divider.dart';
import 'package:crush_app/src/shared/components/buttons/button.dart';
import 'package:crush_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:crush_app/src/shared/components/dialogs/feedback.dart';
import 'package:crush_app/src/shared/components/forms/input.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget implements AutoRouteWrapper {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo =
        DateTime(now.year - 18, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: eighteenYearsAgo, // Date par défaut
      firstDate: DateTime(1900), // Date minimale
      lastDate: eighteenYearsAgo, // Date maximale
      locale: const Locale("fr"), // Langue française
    );

    if (pickedDate != null) {
      setState(() {
        // Met à jour le champ de texte avec la date sélectionnée
        context
            .read<AuthProvider>()
            .onChangeValue('dob', DateFormat('dd/MM/yyyy').format(pickedDate));
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Loader lorsque l'inscription est en cours
        if (authProvider.isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingDialog.show(context: context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingDialog.hide(context: context);
          });
        }

        // Succès : Redirection vers la page de connexion
        if (authProvider.isSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // context.router.push(const LoginRoute());
          });
        }

        // Erreur : Affichage du message d'erreur
        if (authProvider.errorMessage != null && !authProvider.isSuccess) {
          log("authProvider.errorMessage: =======+== +" +
              authProvider.errorMessage.toString());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FeedbackOverlay().show(
                context, authProvider.errorMessage.toString() ?? "",
                type: FeedbackType.error);
            // context.read<AuthProvider>().resetState();
          });
        }

        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                const Gap.vertical(height: Dimens.tripleSpacing),
                Text(
                  I18n.of(context).signup_title,
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
                            context
                                .read<AuthProvider>()
                                .onChangeValue('phone', phone.completeNumber);
                          },
                        ),
                        const Gap.vertical(height: Dimens.doubleSpacing),
                        TextFormField(
                          controller: _usernameController,
                          onChanged: (value) => context
                              .read<AuthProvider>()
                              .onChangeValue("username", value),
                          decoration: InputDecoration(
                            labelText: 'votre pseudo',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            suffixIcon: Icon(Icons.person),
                          ),
                        ),
                        const Gap.vertical(height: Dimens.doubleSpacing),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Date de naissance',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                        const Gap.vertical(height: Dimens.doubleSpacing),
                        Input(
                          autofillHints: const [AutofillHints.password],
                          controller: _passwordController,
                          isPassword: !_isPasswordVisible,
                          labelText: I18n.of(context).login_passwordLabel,
                          hintText: I18n.of(context).login_passwordHint,
                          onChanged: (value) => context
                              .read<AuthProvider>()
                              .onChangeValue("password", value),
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
                          onSubmitted: (_) => _onSignup(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap.vertical(height: Dimens.spacing),
                Container(
                  child: context.watch<AuthProvider>().isLoading
                      ? CircularProgressIndicator()
                      : Button.primary(
                          height: 50,
                          title: I18n.of(context).signup_title,
                          onPressed: _onSignup,
                        ),
                ),
                const Gap.vertical(height: Dimens.doubleSpacing),
                LabeledDivider(
                  label: I18n.of(context).or,
                ),
                const Gap.vertical(height: Dimens.doubleSpacing),
                Button.outline(
                  height: 50,
                  title: I18n.of(context).login_title,
                  onPressed: () {
                    _gotLogin();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSignup() {
    var body = {
      "username": _usernameController.text,
      "password": _passwordController.text,
      "phone": _phoneController.text,
      "dob": _dateController.text
    };
    context.read<AuthProvider>().signup(context);
    // context.router.push(const HomeRoute()),
  }

  void _gotLogin() {
    goTo(context, '/');
    // context.router.push(const LoginRoute());
    // AutoRouter.of(context).push();
  }
}
