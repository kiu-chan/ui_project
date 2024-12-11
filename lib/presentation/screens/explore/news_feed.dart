import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/application/news_feed_bloc/news_feed_bloc.dart';
import 'package:ui_project/application/news_feed_bloc/news_feed_state.dart';
import 'package:ui_project/application/users_bloc/users_bloc.dart'; // Import UsersBloc
import 'package:ui_project/application/users_bloc/users_state.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/screens/explore/post_screen.dart';
import 'package:ui_project/presentation/widgets/card_newsfeed.dart';

class NewsfeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsFeedBloc, NewsFeedState>(builder: (context, state) {
      if (state is NewsFeedLoading) {
        return const Center(child: AppLoading.loading);
      } else if (state is NewsFeedLoaded) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final datas = state.data[index];

                print(
                    'Avatar: ${datas.avatar}, UserName: ${datas.userName}, Image: ${datas.imageUrl}, Time: ${datas.timestamp}, Content: ${datas.content}');

                return CardNewsfeed(
                  avatar: datas.avatar,
                  userName: datas.userName,
                  image: datas.imageUrl,
                  time: datas.timestamp,
                  content: datas.content,
                );
              },
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: 25,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(),
                    ),
                  );
                },
                child: Icon(
                  LucideIcons.plus,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      } else if (state is NewsFeedError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(
          child: Text('No data'),
        );
      }
    });
  }
}
