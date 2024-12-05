import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ui_project/application/cultures_bloc/cultures_bloc.dart';
import 'package:ui_project/application/cultures_bloc/cultures_event.dart';
import 'package:ui_project/application/destinations_bloc/destination_event.dart';
import 'package:ui_project/application/destinations_bloc/destnation_bloc.dart';
import 'package:ui_project/application/festivals_bloc/festival_bloc.dart';
import 'package:ui_project/application/foods_bloc/food_bloc.dart';
import 'package:ui_project/application/foods_bloc/food_event.dart';
import 'package:ui_project/application/map_cubit/culture_map_cubit.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/application/map_cubit/fes_map_cubit.dart';
import 'package:ui_project/application/map_cubit/food_map_cubit.dart';
import 'package:ui_project/application/map_cubit/map_cubit.dart';
import 'package:ui_project/application/saved_cubit/saved_cultures_cubit.dart';
import 'package:ui_project/application/saved_cubit/saved_destinations_cubit.dart';
import 'package:ui_project/application/saved_cubit/saved_festivals_cubit.dart';
import 'package:ui_project/application/step_screen_cubit/step_cubit.dart';
import 'package:ui_project/application/theme_bloc/theme_bloc.dart';
import 'package:ui_project/core/constant/theme.dart';
import 'package:ui_project/data/repositories/home_repositories/cultures_repositories.dart';
import 'package:ui_project/data/repositories/home_repositories/destionation_repositories.dart';
import 'package:ui_project/data/repositories/home_repositories/festival_repositories.dart';
import 'package:ui_project/data/repositories/home_repositories/food_repositories.dart';
import 'package:ui_project/presentation/screens/auth/main_page.dart';
import '../../application/festivals_bloc/festival_event.dart';
import '../../application/saved_cubit/saved_foods_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => PopularDestnationBloc(
            repositories: PopularDestionationRepositories(),
          )..add(
              LoadPopularDestination(),
            ),
        ),
        BlocProvider(
          create: (context) => PopularCulturesBloc(
            repositories: PopularCultureRepositories(),
          )..add(
              LoadedPopularCultures(),
            ),
        ),
        BlocProvider(
          create: (context) => PopularFestivalBloc(
            repositories: PopularFestivalRepositories(),
          )..add(
              LoadedPopularFestival(),
            ),
        ),
        BlocProvider(
          create: (context) => PopularFoodBloc(
            repositories: PopularFoodRepositories(),
          )..add(
              LoadedPopularFood(),
            ),
        ),
        BlocProvider(
          create: (context) => SavedCulturesCubit(),
        ),
        BlocProvider(
          create: (context) => SavedDestinationsCubit(),
        ),
        BlocProvider(
          create: (context) => SavedFoodsCubit(),
        ),
        BlocProvider(
          create: (context) => SavedFestivalsCubit(),
        ),
        BlocProvider(
          create: (context) => UserLocationCubit()..getUserLocation(),
        ),
        BlocProvider(
          create: (context) => MapDesCubit()..getPosition(),
        ),
        BlocProvider(
          create: (context) => FesMapCubit()..getPosition(),
        ),
        BlocProvider(
          create: (context) => CultureMapCubit()..getPosition(),
        ),
        BlocProvider(
          create: (context) => FoodMapCubit()..getPosition(),
        ),
        BlocProvider(
          create: (context) => StepCubit(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            home: MainPage(),
          );
        },
      ),
    );
  }
}
