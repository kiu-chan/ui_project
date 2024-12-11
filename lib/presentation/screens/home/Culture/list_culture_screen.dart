import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/application/cultures_bloc/cultures_bloc.dart';
import 'package:ui_project/application/cultures_bloc/cultures_event.dart';
import 'package:ui_project/application/cultures_bloc/cultures_state.dart';
import 'package:ui_project/application/saved_cubit/saved_cultures_cubit.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/data/models/Home/culture_model.dart';
import 'package:ui_project/presentation/widgets/detail.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import '../../../../core/constant/assets.dart';
import '../../../widgets/list_page.dart';

class ListCulture extends StatelessWidget {
  const ListCulture({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularCulturesBloc>().add(LoadedAllCultures());
    return Scaffold(
      appBar: CustomeAppbar(
        title: 'Văn hóa',
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
                          widget:  BlocBuilder<SavedCulturesCubit, List<CultureModel>>(
                        builder: (context, state) {
                          final isSaved =
                              state.any((item) => item.image == culture.image);
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<SavedCulturesCubit>()
                                  .toggleSave(context, culture);
                              
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
                  title: culture.title,
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
                      child:
                          BlocBuilder<SavedCulturesCubit, List<CultureModel>>(
                        builder: (context, state) {
                          final isSaved =
                              state.any((item) => item.image == culture.image);
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<SavedCulturesCubit>()
                                  .toggleSave(context, culture);
                              
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
          } else if (state is PopularCultureError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
