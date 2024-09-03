import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/clinic_card/data/providers/programProvider.dart';
import 'package:nishauri/src/features/common/data/providers/shortcut_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class Greetings extends ConsumerWidget {
  final String? image;
  final String name;

  const Greetings({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final programState = ref.watch(programProvider);

    // Check if the program list is empty or if all programs are inactive
    final showUpdateProgram =
    programState.when(
      data: (programs) => programs.isEmpty ||
          programs.every((program) => program == 0),
      error: (error, stack) => false,
      loading: () => false,
    );

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(Constants.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey, 👋",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    name == 'Null Null' || name == null
                        ? GestureDetector(
                      onTap: () {
                        context.goNamed(RouteNames.PROFILE_EDIT_FORM);
                      },
                      child: Text(
                        'Click here to update your profile',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.red,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                        : Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Text(
                      DateFormat("EEEE, MMMM dd").format(DateTime.now()),
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                if (showUpdateProgram)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Update program",
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            IconButton(
                              icon: const Icon(
                                Icons.info_outline,
                                size: 40,
                                color: Constants.bpBgColor,
                              ),
                              onPressed: () {
                                // Handle the tap event here
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text(
                                      'You are not registered to any program. Kindly register to a program to have your data personalized.',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    content: Text(
                                      'Touch on OK to select and register a program',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          context.goNamed(RouteNames.PROGRAME_REGISTRATION_SCREEN);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ]
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
