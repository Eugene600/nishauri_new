import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/routes.dart';
import '../../../../utils/constants.dart';
import '../../../hiv/data/providers/art_appointmen_provider.dart';

class Appointments extends HookConsumerWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artAppointmentsAsync = ref.watch(artAppointmentProvider);
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return artAppointmentsAsync.when(
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Text(
              "Upcoming appointments",
              style: theme.textTheme.titleSmall,
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              height: screenSize.height * 0.10,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            ),
            items: data
                .where((artAppointment) => // Filter only upcoming appointments
            DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date)
                        .difference(DateTime.now())
                        .inDays >=
                    0)
                .map(
              (artAppointment) {
                return Builder(
                  builder: (BuildContext context) {
                    return AppCard(
                      onTap: (){
                        context.goNamed(
                          RouteNames.HIV_ART_APPOINTMENT_DETAILS,
                          extra: artAppointment,
                        );
                      },
                      color: theme.colorScheme.onPrimary,
                      variant: CardVariant.ELEVETED,
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(
                            Constants.SPACING,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                Constants.ROUNDNESS,
                              ),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month),
                            ],
                          ),
                        ),
                        title:
                            Text(artAppointment.appointment_type??'', maxLines: 1),
                        titleTextStyle: theme.textTheme.titleSmall
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                            "${DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date).difference(DateTime.now()).inDays} days Remaining"),
                        subtitleTextStyle: theme.textTheme.bodySmall,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('d').format(
                                  DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date)
                              ),
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat("MMM").format(DateFormat('EEEE, MMMM d y').parse(artAppointment.appointment_date)),
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
      error: (error, _) => Container(),
      loading: () => const Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Loading appointments "),
              CircularProgressIndicator()
            ]),
      ),
    );
  }
}
