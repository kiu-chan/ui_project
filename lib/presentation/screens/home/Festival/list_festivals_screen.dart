import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_festivals_bloc/popular_festival_bloc.dart';
import 'package:ui_project/application/popular_festivals_bloc/popular_festival_event.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/detail.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import 'package:ui_project/presentation/widgets/list_page.dart';
import '../../../../application/popular_festivals_bloc/popular_festival_state.dart';

class ListFestivalsScreen extends StatelessWidget {
  const ListFestivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularFestivalBloc>().add(LoadedAllFestival());
    return Scaffold(
      appBar: CustomeAppbar(
        title: 'Popular Festivals',
      ),
      body: BlocBuilder<PopularFestivalBloc, PopularFestivalState>(
          builder: (context, state) {
        if (state is PopularFestivalLoading) {
          return const Center(child: AppLoading.loading);
        } else if (state is PopularFestivalLoaded) {
          return ListView.builder(
            itemCount: state.festival.length,
            itemBuilder: (context, index) {
              final festivals = state.festival[index];
              return ListPage(
                  address: festivals.address,
                  image: festivals.image[0],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: festivals.title,
                          image: festivals.image,
                          address: festivals.address,
                          description: festivals.description,
                          history: festivals.history,
                          feature: festivals.feature[1],
                        ),
                      ),
                    );
                  },
                  title: festivals.title);
            },
          );
        } else if (state is PopularFestivalError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      }),
    );
  }
}
