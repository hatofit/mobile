import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/ui/ui.dart';
import 'package:hatofit/utils/utils.dart';

class StartFreeWorkoutView extends StatefulWidget {
  final bool isFreeWorkout;
  final UserEntity user;
  final BleEntity? device;
  final ExerciseEntity? exercise;
  const StartFreeWorkoutView({
    super.key,
    required this.isFreeWorkout,
    required this.user,
    required this.device,
    this.exercise,
  });

  @override
  State<StartFreeWorkoutView> createState() => _StartFreeWorkoutViewState();
}

class _StartFreeWorkoutViewState extends State<StartFreeWorkoutView> {
  int second = 0;
  BleEntity? device;
  Timer? timer;
  int hrTimeout = 0;
  DateTime? startTime;
  DateTime now = DateTime.now();
  Duration duration = Duration.zero;
  @override
  void initState() {
    startTime = DateTime.now();
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      now = DateTime.now();
      setState(() {
        second++;
        duration = now.difference(startTime!);
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<WorkoutCubit>().isStarted = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) return;
        context.finishWorkout();
      },
      child: Parent(
        floatingButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            context.finishWorkout(
              isFreeWorkout: widget.isFreeWorkout,
              user: widget.user,
              device: device,
              exercise: widget.exercise,
            );
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.stop,
                color: Colors.white,
              ),
              SizedBox(
                width: Dimens.width8,
              ),
              Text(
                Strings.of(context)!.endExercise,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
        child: BlocConsumer<NavigationCubit, NavigationState>(
            listenWhen: (p, c) => p.hrSample != c.hrSample,
            listener: (context, state) {
              if (state.conState == BluetoothConnectionState.disconnected) {
                Strings.of(context)!.deviceDisconnected.toToastError(context);
                Future.delayed(const Duration(seconds: 1), () {
                  context.finishWorkout(
                    isFreeWorkout: widget.isFreeWorkout,
                    user: widget.user,
                    device: device,
                    exercise: widget.exercise,
                  );
                });
              }
              if (state.hrSample?.hr == 0) {
                hrTimeout++;
                if (hrTimeout > 500) {
                  Strings.of(context)!
                      .fiveMinutesPassedWithZeroHeartRate
                      .toToastError(context);
                  Future.delayed(const Duration(seconds: 1), () {
                    context.finishWorkout(
                      isFreeWorkout: widget.isFreeWorkout,
                      user: widget.user,
                      device: device,
                      exercise: widget.exercise,
                    );
                  });
                }
              } else {
                hrTimeout = 0;
              }
              device = state.cDevice;
              final wCub = context.read<WorkoutCubit>();
              if (wCub.isStarted == true) {
                wCub.receiveStreamData(
                  hr: state.hrSample,
                  user: widget.user,
                  ecg: state.ecgSample,
                  acc: state.accSample,
                  gyro: state.gyroSample,
                  magnetometer: state.magnetometerSample,
                  ppg: state.ppgSample,
                  second: second,
                  timeStamp: now,
                  duration: duration,
                  year: startTime?.year ?? 0,
                );
              }
            },
            buildWhen: (p, c) => p.hrSample != c.hrSample,
            builder: (context, state) {
              final wCub = context.read<WorkoutCubit>();
              final ses = wCub.ses;
              if (ses.hrZoneType == HrZoneType.max && wCub.isAlreadyVibrating) {
                Strings.of(context)!
                    .maxHeartRateReached
                    .toToastError(context, textAlign: TextAlign.center);
              }
              return state.hrSample != null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          ExerciseCard(
                            exercise: widget.exercise,
                            devices: state.cDevice,
                          ),
                          SizedBox(height: Dimens.height8),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.width16,
                                vertical: Dimens.height8),
                            child: Column(
                              children: [
                                DurationBox(duration: duration),
                                SizedBox(height: Dimens.height8),
                                Row(
                                  children: [
                                    Expanded(
                                        child: HrCard(hr: state.hrSample!.hr)),
                                    SizedBox(width: Dimens.width8),
                                    Expanded(
                                        child: CaloriesCard(
                                      calories: ses.calories,
                                      unit:
                                          widget.user.metricUnits?.energyUnits,
                                    )),
                                  ],
                                ),
                                SizedBox(height: Dimens.height8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: HrPercentGauge(
                                        percent: ses.hrPecentage,
                                        zoneType: ses.hrZoneType ??
                                            HrZoneType.veryLight,
                                      ),
                                    ),
                                    SizedBox(width: Dimens.width8),
                                    Expanded(
                                        child: HrZoneGauge(
                                      percent: ses.hrPecentage,
                                      zoneType: ses.hrZoneType ??
                                          HrZoneType.veryLight,
                                    )),
                                  ],
                                ),
                                SizedBox(height: Dimens.height8),
                                HrChart(session: ses),
                                SizedBox(height: Dimens.height64),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container();
            }),
      ),
    );
  }
}
