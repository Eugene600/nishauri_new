import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/RadioGroup.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? otpCode;
  String? verificationMode;
  bool _sent = false;
  bool _canSubmit = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _formKey.currentState!.save();
            });
            // If the form is valid, display a snack-bar. In the real world,
            // you'd often call a server or save the information in a database.
            final authStateNotifier = ref.read(authStateProvider.notifier);
            final authState = ref.read(authStateProvider);
            authStateNotifier.verify(otpCode!);
            if (authState.isAccountVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Verification successfully!,')),
              );
            }
          }
        }

        return Scaffold(
          body: ResponsiveWidgetFormLayout(
            buildPageContent: (context, color) => SafeArea(
              child: Container(
                padding: const EdgeInsets.all(Constants.SPACING * 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: Constants.SPACING),
                          DecoratedBox(
                            decoration: const BoxDecoration(),
                            child: SvgPicture.asset(
                              "assets/images/security.svg",
                              semanticsLabel: "Security",
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          ),
                          const SizedBox(height: Constants.SPACING),
                          const Text(
                            "Account Verification",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: Constants.SPACING),
                          Text(
                            "Kindly use the OTP Code sent to you\n to complete account verification.\n\nReceive code through:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: Constants.SPACING),
                          RadioGroup(
                            items: [
                              RadioGroupItem(
                                  value: "email",
                                  title: "lawiomosh3@mail.com  ",
                                  icon: Icons.email),
                              RadioGroupItem(
                                  value: "phone",
                                  title: "+254793889658  ",
                                  icon: Icons.phone),
                            ],
                            value: verificationMode,
                            onValueChanged: (value) {
                              setState(() {
                                verificationMode = value.toString();
                              });
                            },
                          ),
                          const SizedBox(height: Constants.SPACING),
                          FormInputTextField(
                            placeholder: "Enter OTP Verification code",
                            onSaved: (value) => otpCode = value,
                            prefixIcon: Icons.account_circle,
                            readOnly: !(verificationMode?.isNotEmpty == true),
                            surfixIcon: Text(
                              _sent ? "Resend Code" : "Get code",
                            ),
                            onsurfixIconPressed: () {
                              setState(() {
                                _sent = true;
                              });
                            },
                            label: "OTP verification ode",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChangeText: (value) {
                              setState(() {
                                _canSubmit = value.isNotEmpty;
                              });
                            },
                          ),
                          const SizedBox(height: Constants.SPACING),
                          const SizedBox(height: Constants.SPACING),
                          Button(
                            title: "Verify",
                            onPress: _canSubmit ? handleSubmit : null,
                          ),
                          const SizedBox(
                            height: Constants.SPACING,
                          ),
                          Consumer(builder: (context, ref, child) { return LinkedRichText(
                            linked: "",
                            unlinked: "Back to login",
                            onPress: () =>
                                ref.read(authStateProvider.notifier).logout(),
                          ); },)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
