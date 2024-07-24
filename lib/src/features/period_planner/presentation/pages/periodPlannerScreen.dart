import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/periodCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/periodInfoCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodPlannerScreen extends StatefulWidget {
  const PeriodPlannerScreen({super.key});

  @override
  State<PeriodPlannerScreen> createState() => _PeriodPlannerScreenState();
}

class _PeriodPlannerScreenState extends State<PeriodPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Track Periods 🌸",
            color: Constants.periodPlanner,
          ),
          const SizedBox(height: Constants.SPACING),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: CustomCalendar(initialFormat: CalendarFormat.week,),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(
                      width: Constants.SPACING * 30, // Adjust the width as needed
                      height: Constants.SPACING * 30, // Adjust the height as needed
                      child: CircularProgressIndicator(
                        value: 0.5, // example value for the progress
                        strokeWidth: 10,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Constants.periodPlanner),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Period',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING), 
                        const Text(
                          'Day 3',
                          style: TextStyle(fontSize: 38, color: Constants.periodPlanner,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING), 
                        const Text(
                          'Low Chances of getting Pregnant',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: Constants.SPACING), 
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, 
                            backgroundColor: Constants.periodPlanner, // background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                          ),
                          child: const Text(
                            'Daily Log',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
