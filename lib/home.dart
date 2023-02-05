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
  late double yearPercent;
  late double monthPercent;
  late double dayPercent;

  // Update the time and refresh the UI
  void _updateTime() {
    setState(() {
      yearPercent = TimeUtils.getYearPercentage();
      monthPercent = TimeUtils.getMonthPercentage();
      dayPercent = TimeUtils.getDayPercentage();
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.only(
                  right: 40.0,
                  left: 40.0,
                ),
                child: Consumer<PreferencesProvider>(
                  builder: (context, provider, child) {
                    return Column(
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
                          dayProgressBar,
                          monthProgressBar,
                          yearProgressBar,
                        ] else ...[
                          yearProgressBar,
                          monthProgressBar,
                          dayProgressBar,
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
