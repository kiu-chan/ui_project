import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/step_screen_cubit/step_cubit.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import '../../application/step_screen_cubit/step_state.dart';

class CardStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index; 

  const CardStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCubit, StepTripState>(
      builder: (context, state) {
        final isSelected = context.read<StepCubit>().isStepSelected(index);

        return GestureDetector(
          onTap: () {
            context.read<StepCubit>().toggleSelection(index);
          },
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 1,
            child: Card(
              color: AppColors.backGroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ListTile(
                title: Text(
                  title,
                  style: AppTextStyle.headLineStyle,
                ),
                subtitle: Text(
                  subtitle,
                  style: AppTextStyle.bodyStyle1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

