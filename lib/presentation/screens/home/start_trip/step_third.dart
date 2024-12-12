import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/step_screen_cubit/step_cubit.dart';
import 'package:ui_project/application/step_screen_cubit/step_state.dart';
import 'package:ui_project/presentation/screens/home/start_trip/trip_data_manager.dart';

class StepThird extends StatelessWidget {
  const StepThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBudgetOption(context, 'Dưới 2 triệu', '1-2 triệu VNĐ cho chuyến đi của bạn', 0),
        _buildBudgetOption(context, '2-5 triệu', '2-5 triệu VNĐ cho chuyến đi của bạn', 1),
        _buildBudgetOption(context, '5-10 triệu', '5-10 triệu VNĐ cho chuyến đi của bạn', 2),
        _buildBudgetOption(context, 'Trên 10 triệu', 'Trên 10 triệu VNĐ cho chuyến đi của bạn', 3),
      ],
    );
  }

  Widget _buildBudgetOption(BuildContext context, String title, String subtitle, int index) {
    return BlocBuilder<StepCubit, StepTripState>(
      builder: (context, state) {
        final isSelected = context.read<StepCubit>().isStepSelected(index);

        return GestureDetector(
          onTap: () {
            context.read<StepCubit>().toggleSelection(index);
            // Lưu thông tin ngân sách khi người dùng chọn
            TripDataManager().setBudget(title);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
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
        );
      },
    );
  }
}