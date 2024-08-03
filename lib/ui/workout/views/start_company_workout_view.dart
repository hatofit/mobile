import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/ui/ui.dart';
import 'package:hatofit/utils/utils.dart';

class StartCompanyWorkoutView extends StatefulWidget {
  final bool isFreeWorkout;
  final UserEntity user;
  final BleEntity? device;
  final ExerciseEntity? exercise;
  final String companyExerciseId;

  const StartCompanyWorkoutView({
    super.key,
    required this.isFreeWorkout,
    required this.user,
    required this.device,
    this.exercise,
    required this.companyExerciseId,
  });

  @override
  State<StartCompanyWorkoutView> createState() =>
      _StartCompanyWorkoutViewState();
}

class _StartCompanyWorkoutViewState extends State<StartCompanyWorkoutView> {
  int second = 0;
  BleEntity? device;
  Timer? timer;
  int hrTimeout = 0;
  DateTime? startTime;
  DateTime now = DateTime.now();
  Duration duration = Duration.zero;

  int instructionIndex = 0;

  CountDownController countDownTimer = CountDownController();

  bool isNowExerciseFinish = false;
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
    final exercise = widget.exercise;
    final instructions = exercise?.instructions ?? [];
    final energyUnit = widget.user.metricUnits?.energyUnits ?? 'cal';
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // if (!didPop) return;
        context.finishWorkout(
          isFreeWorkout: false,
          user: widget.user,
          device: device,
          exercise: widget.exercise,
          companyExerciseId: widget.companyExerciseId,
        );
      },
      child: BlocConsumer<NavigationCubit, NavigationState>(
        listener: (BuildContext context, NavigationState state) {
          if (state.conState == BluetoothConnectionState.disconnected) {
            Strings.of(context)!.deviceDisconnected.toToastError(context);
            Future.delayed(const Duration(seconds: 1), () {
              context.finishWorkout(
                isFreeWorkout: false,
                user: widget.user,
                device: device,
                exercise: widget.exercise,
                companyExerciseId: widget.companyExerciseId,
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
                  isFreeWorkout: false,
                  user: widget.user,
                  device: device,
                  exercise: widget.exercise,
                  companyExerciseId: widget.companyExerciseId,
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
        builder: (context, state) {
          final wCub = context.read<WorkoutCubit>();
          final ses = wCub.ses;
          if (ses.hrZoneType == HrZoneType.max && wCub.isAlreadyVibrating) {
            Strings.of(context)!
                .maxHeartRateReached
                .toToastError(context, textAlign: TextAlign.center);
          }
          final zone = ses.hrZoneType ?? HrZoneType.veryLight;
          return Parent(
            appBar: AppBar(
              title: Text(
                instructions[instructionIndex].name ?? 'Rest',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                instructions[instructionIndex].type == 'rest'
                    ? Container()
                    : IconButton(
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.only(right: 16))),
                        onPressed: () async {
                          final videoUrl =
                              instructions[instructionIndex].content?.video ??
                                  Constants.get.exercisePlaceholderVideo;
                          final detail = await videoUrl.videoURL();
                          _showVideoModal(
                              instructions[instructionIndex], detail);
                        },
                        icon: const Icon(Icons.movie),
                      )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CachedNetworkImage(
                  height: 300.w,
                  width: 300.w,
                  imageUrl: instructions[instructionIndex].content?.image ??
                      Constants.get.placeholderImage,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.favorite,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(width: 8),
                              Text(
                                state.hrSample?.hr == null
                                    ? '--'
                                    : '${state.hrSample?.hr}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                color: Theme.of(context)
                                    .extension<AppColors>()!
                                    .mauve!,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${ses.calories.round()} ${energyUnit}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thermostat,
                                  color: Theme.of(context)
                                      .extension<AppColors>()!
                                      .roseWater!),
                              const SizedBox(width: 8),
                              Text(
                                '${ses.hrPecentage} %',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.speed, color: zone.color),
                              const SizedBox(width: 8),
                              Text(
                                zone.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                instructions[instructionIndex].type == 'rest'
                    ? Column(
                        children: [
                          const SizedBox(height: 16),
                          if (instructionIndex + 1 < instructions.length)
                            Text(
                              'Next : ${instructions[instructionIndex + 1].name.toString()}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 16),
                CircularCountDownTimer(
                  width: 150,
                  height: 150,
                  duration: instructions[instructionIndex].duration ?? 0 + 1,
                  ringColor: Theme.of(context).cardColor,
                  fillColor: Theme.of(context).primaryColor,
                  controller: countDownTimer,
                  strokeWidth: 16,
                  strokeCap: StrokeCap.round,
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  isReverse: true,
                  onComplete: () {
                    setState(() {
                      isNowExerciseFinish = true;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  child: isNowExerciseFinish
                      ? ElevatedButton(
                          onPressed: () {
                            nextInstruction(instructions);
                          },
                          child: Text(
                            isNowExerciseFinish ? 'Next' : 'Finish',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (countDownTimer.isPaused.value == true) {
                              countDownTimer.resume();
                            } else {
                              countDownTimer.pause();
                            }
                          },
                          child: Text(
                            countDownTimer.isPaused.value == false
                                ? 'Pause'
                                : 'Resume',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  void nextInstruction(List<ExerciseInstructionEntity> instructions) {
    if (instructionIndex < instructions.length - 1) {
      setState(() {
        instructionIndex++;
      });
    } else {
      context.finishWorkout(
        isFreeWorkout: false,
        user: widget.user,
        device: device,
        exercise: widget.exercise,
        companyExerciseId: widget.companyExerciseId,
      );
    }
  }

  void _showVideoModal(
      ExerciseInstructionEntity? instruction, YtVideo ytVideo) {
    if (instruction == null) return;
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoPlayer(
                  ytVideo: ytVideo,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: const Text('Close'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class VideoPlayer extends StatefulWidget {
  final YtVideo ytVideo;
  const VideoPlayer({super.key, required this.ytVideo});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    final first = widget.ytVideo.videoInfo.first.url.toString();
    final Map<String, String> resolutions = {};
    for (final video in widget.ytVideo.videoInfo) {
      resolutions[video.qualityLabel] = video.url.toString();
    }
    final source = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      first,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 10 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
        key: first,
      ),
      resolutions: resolutions,
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: widget.ytVideo.title,
        author: widget.ytVideo.author,
        imageUrl: widget.ytVideo.imageUrl,
      ),
    );

    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
      ),
      betterPlayerDataSource: source,
    );
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
