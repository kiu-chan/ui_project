import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/application/destinations_bloc/destination_state.dart';
import 'package:ui_project/application/destinations_bloc/destnation_bloc.dart';
import 'package:ui_project/application/saved_cubit/saved_destinations_cubit.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';
import 'package:ui_project/presentation/widgets/detail.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import 'package:ui_project/presentation/widgets/list_page.dart';
import '../../../../application/destinations_bloc/destination_event.dart';
import '../../../../core/constant/assets.dart';

class ListDestinationsScreen extends StatelessWidget {
  const ListDestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularDestnationBloc>().add(LoadedAllDestination());

    return Scaffold(
      appBar: CustomeAppbar(title: 'Điểm đến'),
      body: BlocBuilder<PopularDestnationBloc, PopularDestinationState>(
          builder: (contex, state) {
        if (state is PopularDestinationLoading) {
          return const Center(child: AppLoading.loading);
        } else if (state is PopularDestinationLoaded) {
          return ListView.builder(
            itemCount: state.destination.length,
            itemBuilder: (context, index) {
              final destinations = state.destination[index];
              return ListPage(
                address: destinations.address,
                image: destinations.image[0],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        title: destinations.title,
                        image: destinations.image,
                        address: destinations.address,
                        description: destinations.description,
                        history: destinations.history,
                        feature: destinations.feature,
                        widget: BlocBuilder<SavedDestinationsCubit,
                            List<DestinationsModels>>(
                          builder: (context, state) {
                            final isSaved = state.any(
                                (item) => item.image == destinations.image);
                            return IconButton(
                              onPressed: () {
                                context
                                    .read<SavedDestinationsCubit>()
                                    .toogleSave(
                                      context,
                                      destinations,
                                    );
                              },
                              icon: isSaved
                                  ? SvgPicture.asset(AppAssets.BookMarkFill)
                                  : SvgPicture.asset(AppAssets.BookMark),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                title: destinations.title,
                widget: Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: BlocBuilder<SavedDestinationsCubit,
                        List<DestinationsModels>>(
                      builder: (context, state) {
                        final isSaved = state
                            .any((item) => item.image == destinations.image);
                        return IconButton(
                          onPressed: () {
                            context.read<SavedDestinationsCubit>().toogleSave(
                                  context,
                                  destinations,
                                );
                          },
                          icon: isSaved
                              ? SvgPicture.asset(AppAssets.BookMarkFill)
                              : SvgPicture.asset(AppAssets.BookMark),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is PopularDestinationError) {
          return Center(
              child: Text(
            state.message,
          ));
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      }),
    );
  }
}
