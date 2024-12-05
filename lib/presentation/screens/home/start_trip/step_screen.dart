import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/step_screen_cubit/step_cubit.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/enums/enums.dart';
import 'package:ui_project/presentation/screens/home/start_trip/step_one.dart';
import 'package:ui_project/presentation/screens/home/start_trip/step_second.dart';
import 'package:ui_project/presentation/screens/home/start_trip/step_third.dart';
import '../../../../application/step_screen_cubit/step_state.dart';
import '../../../../core/constant/textStyle.dart';

class StepScreen extends StatelessWidget {
  const StepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StepCubit, StepTripState>(
      listener: (context, state) {},
      child: BlocBuilder<StepCubit, StepTripState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backGroundColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            context.read<StepCubit>().preStep(context);
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(15),
                              minHeight: 10,
                              value: (state.currentStep + 1) /
                                  context.read<StepCubit>().totalSteps,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      step[state.currentStep]['title'] ?? '',
                      style: AppTextStyle.headStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      step[state.currentStep]['subtitle'] ?? '',
                      style: AppTextStyle.bodyStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    state.currentStep == 0
                        ? StepOne()
                        : state.currentStep == 1
                            ? StepSecond()
                            : state.currentStep == 2
                                ? StepThird()
                                : Container(),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          context.read<StepCubit>().nextStep();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Tiếp tục",
                            style: AppTextStyle.buttonText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
