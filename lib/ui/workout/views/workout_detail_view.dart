import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/service_locator.dart';
import 'package:hatofit/ui/ui.dart';
import 'package:hatofit/utils/utils.dart';

class WorkoutDetailView extends StatefulWidget {
  final ExerciseEntity exercise;
  final String companyExerciseId;

  const WorkoutDetailView({
    super.key,
    required this.exercise,
    required this.companyExerciseId,
  });

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView>
    with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  final isExpanded = ValueNotifier<bool>(true);
  final textTitleOpacity = ValueNotifier<double>(1.0);

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset > 170) {
        isExpanded.value = false;
      } else {
        textTitleOpacity.value = 1.0 - (scrollController.offset / 200);
        isExpanded.value = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      listenWhen: (p, c) {
        return p.bleFailure != c.bleFailure || p.cDevice != c.cDevice;
      },
      listener: (context, state) {
        if (state.bleFailure != null) {
          if (state.bleFailure?.message
                  ?.contains("CONNECTION_FAILED_ESTABLISHMENT") ==
              true) {
            Strings.of(context)!.failedConnectToDevice.toToastError(context);
          }
        }
      },
      buildWhen: (p, c) =>
          p.hrSample != c.hrSample ||
          p.cDevice != c.cDevice ||
          p.state != c.state,
      builder: (context, state) {
        return Parent(
          child: Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    pinned: true,
                    expandedHeight: 275,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: isExpanded.value ? Colors.white : Colors.black,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    actions: [
                      state.cDevice != null
                          ? Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        state.hrSample?.hr.toString() ?? '0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.bluetooth_connected,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        state.cDevice?.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      state.state != BluetoothAdapterState.off
                          ? IconButton(
                              icon: const Icon(
                                Icons.bluetooth,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                if (!di.isRegistered<NavigationCubit>()) {
                                  regNavCubit();
                                }
                                context.read<NavigationCubit>().startScan();
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  builder: (context) {
                                    return const DeviceDiscover(
                                        shouldPop: false);
                                  },
                                );
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.bluetooth_disabled,
                                color: Colors.red,
                              ),
                              onPressed: () async => FlutterBluePlus.turnOn(),
                            )
                    ],
                    title: isExpanded.value
                        ? Text(
                            '',
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        : Text(
                            widget.exercise.name ?? '',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: isExpanded.value
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0,
                              ),
                              child: Opacity(
                                opacity: textTitleOpacity.value,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.exercise.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: isExpanded.value
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                    ),
                                    Text(
                                      widget.exercise.description ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.normal,
                                            color: isExpanded.value
                                                ? Colors.grey[400]
                                                : Colors.black,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      background: CachedNetworkImage(
                        colorBlendMode: BlendMode.darken,
                        color: Colors.black.withOpacity(0.5),
                        imageUrl: widget.exercise.thumbnail ??
                            Constants.get.placeholderImage,
                        fit: BoxFit.cover,
                      ),
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
                      ],
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Container(
                        height: 32.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0),
                          ),
                        ),
                        child: Container(
                          width: 40.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timer, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.exercise.duration} s',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              const Icon(Icons.fitness_center, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.exercise.instructions?.length} sets',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final instructions = widget.exercise.instructions ?? [];
                        final instruction = instructions[index];
                        if (instruction.type == 'rest') {
                          return Container();
                        }
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                border: const Border(
                                  top: BorderSide(
                                    color: Colors.black26,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 16, right: 16),
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CachedNetworkImage(
                                        imageUrl: instruction.content?.image ??
                                            Constants.get.placeholderImage,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          instructions[index].name.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.timer, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${instructions[index].duration.toString()} s',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: widget.exercise.instructions?.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 80,
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: FloatingActionButton.extended(
                    extendedPadding:
                        const EdgeInsets.symmetric(horizontal: 32.0),
                    onPressed: () {
                      final wCubit = context.read<WorkoutCubit>();
                      final nCubit = context.read<NavigationCubit>();
                      final res = wCubit.startWorkout(false, widget.exercise);
                      if (!res) {
                        Strings.of(context)!
                            .failedToStartWorkout
                            .toToastError(context, textAlign: TextAlign.center);
                      }
                      if (wCubit.user != null && nCubit.state.cDevice != null) {
                        context.pushNamed(
                          Routes.startCompanyWorkout.name,
                          extra: StartExerciseParams(
                            isFreeWorkout: false,
                            exercise: widget.exercise,
                            user: wCubit.user ?? const UserEntity(),
                            device: nCubit.state.cDevice,
                            companyExerciseId: widget.companyExerciseId,
                          ),
                        );
                      }
                    },
                    label: const Text('Start'),
                    icon: const Icon(Icons.play_arrow),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
