import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/domain/domain.dart';
import 'package:hatofit/ui/ui.dart';
import 'package:hatofit/utils/utils.dart';

class WorkoutView extends StatelessWidget {
  final CompanyEntity company;
  const WorkoutView({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<WorkoutCubit>().getExercises();
      },
      child: Parent(
        appBar: AppBar(
          title: Text(
            '${company.name ?? ''} ${Strings.of(context)!.workout}',
          ),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          buildWhen: (p, c) => p != c,
          builder: (context, state) => state.when(
            loading: () => const Center(child: Loading()),
            failure: (message) {
              if (message is CacheFailure) {
                return Center(
                    child: Text(Strings.of(context)!.noWorkoutMenuFound));
              }
              return Center(child: Text(message.toString()));
            },
            success: (exercises) {
              exercises = exercises.where((e) => e.type!.isNotEmpty).toList();
              return GridView.builder(
                itemCount: exercises.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  ExerciseEntity exercise = exercises[index];

                  final thumbnail = (exercise.thumbnail?.isNotEmpty ?? false)
                      ? exercise.thumbnail ?? Constants.get.placeholderImage
                      : Constants.get.placeholderImage;

                  exercise = exercise.copyWith(
                    thumbnail: thumbnail,
                  );

                  return InkWell(
                    onTap: () => context.pushNamed(
                      Routes.workoutDetail.name,
                      extra: {
                        'exercise': exercise,
                      },
                    ),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 2 / 1.3,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: thumbnail,
                                colorBlendMode: BlendMode.darken,
                                color: context.isDarkMode
                                    ? Colors.black.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.25),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.fitness_center,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${exercise.instructions?.length ?? 0} sets',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${exercise.duration} sec',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
