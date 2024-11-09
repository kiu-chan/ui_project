import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_destinations_bloc/popular_destination_state.dart';
import 'package:ui_project/application/popular_destinations_bloc/popular_destnation_bloc.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/detail.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import 'package:ui_project/presentation/widgets/list_page.dart';
import '../../../../application/popular_destinations_bloc/popular_destination_event.dart';

class ListDestinationsScreen extends StatelessWidget {
  const ListDestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularDestnationBloc>().add(LoadedAllDestination());

    return Scaffold(
      appBar: CustomeAppbar(title: 'Popular Destinations'),
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
                          feature: destinations.feature[1],
                        ),
                      ),
                    );
                  },
                  title: destinations.title);
            },
          );
        } else if (state is PopularDestinationError) {
          return Center(
              child: Text(
            state.message,
          ));
        } else {
          return const Center(child: Text('No Data'),);
        }
      }),
    );
  }
}
