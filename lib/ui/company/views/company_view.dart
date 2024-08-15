import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hatofit/core/core.dart';
import 'package:hatofit/ui/ui.dart';

class CompanyView extends StatelessWidget {
  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<CompanyCubit>().getCompanies(),
      child: Parent(
        appBar: AppBar(
          title: Text(Strings.of(context)!.company),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        child: BlocBuilder<CompanyCubit, CompanyState>(
          buildWhen: (p, c) => p != c,
          builder: (context, state) => state.when(
            loading: () => const Center(child: Loading()),
            failure: (message) {
              if (message is CacheFailure) {
                return Center(
                  child: Text(Strings.of(context)!.noCompanyFound),
                );
              }
              return Center(child: Text(message.toString()));
            },
            success: (companies) {
              return ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return ListTile(
                    title: Text(company.name ?? ''),
                    subtitle: Text(company.description ?? ''),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        company.image ?? Constants.gymPlaceholderImage,
                      ),
                    ),
                    onTap: () => context.pushNamed(
                      Routes.workout.name,
                      extra: {
                        'company': company,
                      },
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
