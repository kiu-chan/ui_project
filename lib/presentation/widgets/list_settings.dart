import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ui_project/application/theme_bloc/theme_bloc.dart';
import 'package:ui_project/application/theme_bloc/theme_event.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';

class ListSettings extends StatelessWidget {
  final String leading;
  final String title;

  final Widget screen;
  const ListSettings({
    super.key,
    required this.leading,
    required this.title,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      leading: SvgPicture.asset(
        leading,
        // ignore: deprecated_member_use
        color: AppColors.iconColor,
        height: 20,
        width: 20,
      ),
      title: Text(
        title,
        style: AppTextStyle.bodyStyle,
      ),
      trailing: title == 'Giao diện'
          ? Switch(
              activeColor: AppColors.primaryColor,
              value: context.read<ThemeBloc>().state == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(
                      ThemeChange(
                        value,
                      ),
                    );
              })
          : Icon(
              LucideIcons.chevronRight,
              color: AppColors.iconColor,
            ),
    );
  }
}
