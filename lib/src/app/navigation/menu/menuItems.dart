import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class MenuItem {
  final Widget icon;
  final String? title;
  final void Function()? onPressed;
  final Color? color;

  MenuItem({required this.icon, this.title, this.onPressed, this.color});
}

MenuItem getProgramMenuItemByProgramCode(
    BuildContext context, String programCode) {
  if (programCode == ProgramCodeNameIds.HIV) {
    return MenuItem(
        icon: const Icon(
          Icons.vaccines,
          size: Constants.iconSize,
        ),
        title: MenuItemNames.HIV_PROGRAM_MENU,
        onPressed: () => context.goNamed(RouteNames.HIV_PROGRAM),
        color: Constants.appointmentsColor);
  } else if (programCode == ProgramCodeNameIds.TB) {
    return MenuItem(
      icon: const Icon(
        Icons.sick,
        size: Constants.iconSize,
      ),
      title: MenuItemNames.TB_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.ASTHMA) {
    return MenuItem(
      icon: const Icon(
        Icons.ac_unit,
        size: Constants.iconSize,
      ),
      title: MenuItemNames.ASTHMA_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.DIABETES) {
    return MenuItem(
      icon: const Icon(
        Icons.monitor_weight_outlined,
        size: Constants.iconSize,
      ),
      title: MenuItemNames.DIABETES_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.CANCER) {
    return MenuItem(
      icon: const Icon(
        Icons.group_work,
        size: Constants.iconSize,
      ),
      title: MenuItemNames.CANCER_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.HYPERTENSION) {
    return MenuItem(
        icon: const Icon(
          Icons.speed,
          size: Constants.iconSize,
        ),
        title: MenuItemNames.HYPERTENSION_PROGRAM_MENU,
        onPressed: () {});
  }
  return MenuItem(
    icon: const Icon(
      Icons.more_horiz,
      size: Constants.iconSize,
    ),
  );
}

List<MenuItem> getGenericMenuItems(BuildContext context) {
  return [
    // MenuItem(
    //   icon: Icons.calendar_month_rounded,
    //   title: MenuItemNames.MY_CALENDAR,
    //   onPressed: () => context.goNamed(RouteNames.EVENTS_CALENDAR),
    // ),
    // MenuItem(
    //   icon: Icons.dashboard_customize_outlined,
    //   title: MenuItemNames.DASHBOARD,
    //   onPressed: () => context.goNamed(RouteNames.DASHBOARD),
    // ),

    MenuItem(
      icon: FaIcon(
        Icons.file_copy_outlined,
        size: Constants.iconSize,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      title: MenuItemNames.PROGRAM_MENU,
      onPressed: () => context.goNamed(RouteNames.PROGRAM_MENU),
    ),

    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/calendar.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          height: 80,
          width: 80,
        ),
        title: MenuItemNames.APPOINTMENTS,
        onPressed: () => context.goNamed(RouteNames.APPOINTMENTS),
        color: Constants.appointmentsColor),
    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/syringe.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          height: 80,
          width: 80,
        ),
        title: MenuItemNames.LAB_RESULTS,
        onPressed: () => context.goNamed(RouteNames.LAB_RESULTS),
        color: Constants.labResultsColor),
    MenuItem(
        icon: FaIcon(
          FontAwesomeIcons.addressCard,
          size: Constants.iconSize,
          color: Colors.blue[400],
        ),
        title: MenuItemNames.MY_CLINIC_CARD,
        onPressed: () => context.goNamed(RouteNames.MY_CLINIC_CARD),
        color: Colors.blue[900]),
    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/house.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          height: 80,
          width: 80,
        ),
        title: MenuItemNames.FACILITY_DIRECTORY,
        onPressed: () => context.goNamed(RouteNames.Facility_Directory),
        color: Constants.facilityDirectoryColor),
    // MenuItem(
    //   icon: Icons.group,
    //   title: MenuItemNames.TREATMENT_SUPPORT,
    //   onPressed: () => context.goNamed(RouteNames.TREATMENT_SUPPORT),
    // ),
    // MenuItem(
    //   icon: Icons.event_note,
    //   title: MenuItemNames.MENSTRUAL_CIRCLE,
    //   onPressed: () => "",
    // ),
    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/calculator.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          height: 80,
          width: 80,
        ),
        title: MenuItemNames.BMI_CALCULATOR,
        onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR),
        color: Constants.bmiCalculatorColor),

    MenuItem(
      // icon: FaIcon(FontAwesomeIcons.capsules, size: Constants.iconSize, color: Colors.teal[200],),
      icon: SvgPicture.asset(
        "assets/images/pills.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: 80,
        height: 80,
      ),
      title: MenuItemNames.DAWA_DROP,
      onPressed: () => context.goNamed(RouteNames.DAWA_DROP),
      color: Constants.dawaDropColor.withOpacity(0.5),
    ),
    // MenuItem(
    //   icon: Icons.move_down,
    //   title: MenuItemNames.FACILITY_VISITS,
    //   onPressed: () => context.goNamed(RouteNames.FACILITY_VISITS),
    // ),
    // MenuItem(
    //   icon: Icons.send,
    //   title: MenuItemNames.CHAT_HCW,
    //   onPressed: () => context.goNamed(RouteNames.CHAT_HCW),
    // ),
  ];
}

List<MenuItem> getMenuItemByNames(BuildContext context, List<String> names) {
  const programNames = ProgramCodeNameIds.SUPPOTED_PROGRAM_CODES;
  return [
    ...getGenericMenuItems(context),
    ...programNames.map((e) => getProgramMenuItemByProgramCode(context, e)),
  ]
      .where(
        (menuItem) => names.any((name) => name == menuItem.title),
      )
      .toList();
}
