import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_progress/provider.dart';
import 'package:time_progress/widgets/fab.dart';

import 'time_utils.dart';
import 'widgets/background.dart';
import 'widgets/progress_bar.dart';

class TimeProgressHomePage extends StatefulWidget {
  const TimeProgressHomePage({super.key});

  @override
  State<TimeProgressHomePage> createState() => _TimeProgressHomePageState();
}

class _TimeProgressHomePageState extends State<TimeProgressHomePage> {
  Timer? timer;

  PreferencesProvider? provider;

  late double yearPercent;
  late double monthPercent;
  late double dayPercent;
  late double workingDayPercent;

  // Update the time and refresh the UI
  void _updateTime() {
    int sh = 8;
    int eh = 17;
    int sm = 0;
    int em = 0;

    if (provider != null) {
      sh = provider!.workingDayStartHour;
      eh = provider!.workingDayEndHour;
      sm = provider!.workingDayStartMinutes;
      em = provider!.workingDayEndMinutes;
    }

    setState(() {
      yearPercent = TimeUtils.getYearPercentage();
      monthPercent = TimeUtils.getMonthPercentage();
      dayPercent = TimeUtils.getDayPercentage();
      workingDayPercent = TimeUtils.getWorkingDayPercentage(sh, eh, sm, em);
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTime();

    timer =
        Timer.periodic(const Duration(milliseconds: 500), (_) => _updateTime());
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<PreferencesProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget yearProgressBar = ProgressBar(
      title: 'Year',
      percent: yearPercent,
    );

    final Widget monthProgressBar = ProgressBar(
      title: 'Month',
      percent: monthPercent,
    );

    final Widget dayProgressBar = ProgressBar(
      title: 'Day',
      percent: dayPercent,
    );

    final Widget workingDayProgressBar = ProgressBar(
      title: 'Workday',
      percent: workingDayPercent,
    );

    return Scaffold(
      floatingActionButton: const Fab(),
      body: Stack(
        children: [
          const Background(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.20,
              ),
              child: Consumer<PreferencesProvider>(
                builder: (context, provider, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).cardColor.withOpacity(
                            provider.mainCardOpacity,
                          ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.only(
                      right: 40.0,
                      left: 40.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (provider.showCurrentDate) ...{
                          Text(
                            TimeUtils.getCurrentDateString(),
                            style: const TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        },
                        if (provider.swapBarsOrder) ...[
                          provider.showWorkingDayBar
                              ? workingDayProgressBar
                              : const SizedBox.shrink(),
                          dayProgressBar,
                          monthProgressBar,
                          yearProgressBar,
                        ] else ...[
                          yearProgressBar,
                          monthProgressBar,
                          dayProgressBar,
                          provider.showWorkingDayBar
                              ? workingDayProgressBar
                              : const SizedBox.shrink(),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
