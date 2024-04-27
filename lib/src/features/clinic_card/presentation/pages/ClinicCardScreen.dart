import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/clinic_card/data/providers/programProvider.dart';
import 'package:nishauri/src/features/clinic_card/presentation/widgets/clinicalDetails.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';

class ClinicCardScreen extends HookConsumerWidget {
  const ClinicCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programAsync = ref.watch(programProvider);
    final currIndex = useState(0);
    return programAsync.when(
      data: (data) {
        final screens =
            data.map((program) => ClinicalDetailsTab(program: program));

        return Scaffold(
          body: Column(
            children: [
              const CustomAppBar(
                title: "My Clinic card",
                icon: Icons.file_present,
                color: Colors.blue,
                subTitle: "Access medical services using \nyour clinic cards",
              ),
              CustomTabBar(
                onTap: (item, index) {
                  currIndex.value = index;
                },
                items: data
                    .map(
                      (program) => CustomTabBarItem(
                        title: program.name,
                        icon: Icons.multiple_stop,
                      ),
                    )
                    .toList(),
                activeIndex: currIndex.value,
                activeColor: Colors.green,
              ),
              Expanded(child: screens.elementAt(currIndex.value))
            ],
          ),
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
