import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_bloc.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_event.dart';
import 'package:ui_project/application/popular_destinations_bloc/popular_destination_event.dart';
import 'package:ui_project/application/popular_destinations_bloc/popular_destnation_bloc.dart';
import 'package:ui_project/application/popular_festivals_bloc/popular_festival_bloc.dart';
import 'package:ui_project/application/popular_festivals_bloc/popular_festival_event.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_bloc.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_event.dart';
import 'package:ui_project/data/repositories/popular_cultures_repositories.dart';
import 'package:ui_project/data/repositories/popular_destionation_repositories.dart';
import 'package:ui_project/data/repositories/popular_festival_repositories.dart';
import 'package:ui_project/data/repositories/popular_food_repositories.dart';
import 'package:ui_project/presentation/screens/auth/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Consumer<LanguageProvider>(
    //   builder: (context, languageProvider, child) {
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       localizationsDelegates: AppLocalizations.localizationsDelegates,
    //       supportedLocales: AppLocalizations.supportedLocales,
    //       locale: languageProvider.currentLocale,
    //       home: const MainPage(),
    //     );
    //   },
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularDestnationBloc(
              repositories: PopularDestionationRepositories())
            ..add(
              LoadPopularDestination(),
            ),
        ),
        BlocProvider(
          create: (context) =>
              PopularCulturesBloc(repositories: PopularCultureRepositories())
                ..add(
                  LoadedPopularCultures(),
                ),
        ),
        BlocProvider(
          create: (context) =>
              PopularFestivalBloc(repositories: PopularFestivalRepositories())
                ..add(
                  LoadedPopularFestival(),
                ),
        ),
        BlocProvider(
          create: (context) =>
              PopularFoodBloc(repositories: PopularFoodRepositories())
                ..add(
                  LoadedPopularFood(),
                ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        //  locale: languageProvider.currentLocale,
        home: const MainPage(),
      ),
    );
  }
}
