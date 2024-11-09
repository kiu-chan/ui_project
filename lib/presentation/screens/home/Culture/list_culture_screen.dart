import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_bloc.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_event.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_state.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/detail.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import 'package:ui_project/presentation/widgets/list_page.dart';

class ListCulture extends StatelessWidget {
  const ListCulture({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularCulturesBloc>().add(LoadedAllCultures());
    return Scaffold(
      appBar: CustomeAppbar(
        title: 'Popular Cultures',
      ),
      body: BlocBuilder<PopularCulturesBloc, PopularCultureState>(
        builder: (context, state) {
          if (state is PopularCultureLoading) {
            return Center(
              child: AppLoading.loading,
            );
          } else if (state is PopularCultureLoaded) {
            return ListView.builder(
              itemCount: state.culture.length,
              itemBuilder: (context, index) {
                final culture = state.culture[index];
                return ListPage(
                  address: culture.address,
                  image: culture.image[0],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: culture.title,
                          image: culture.image,
                          address: culture.address,
                          description: culture.description,
                          history: culture.history,
                          feature: culture.feature[1],
                        ),
                      ),
                    );
                  },
                  title: culture.title,
                );
              },
            );
          } else if (state is PopularCultureError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
