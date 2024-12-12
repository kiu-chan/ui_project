import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/step_screen_cubit/step_state.dart';
import 'package:ui_project/presentation/screens/home/start_trip/review_sumary.dart';

class StepCubit extends Cubit<StepTripState> {
  static const int maxOptionsPerStep = 4;
  
  StepCubit()
      : super(
          StepTripState(
            currentStep: 0,
            isSelected: List.generate(maxOptionsPerStep, (_) => false),
          ),
        );

  final int totalSteps = 3;

  void nextStep(BuildContext context) {
    if (state.currentStep < totalSteps - 1) {
      // Check if any option is selected in the current step
      bool hasSelection = state.isSelected.contains(true);
      if (!hasSelection && state.currentStep != 1) { // Skip check for date picker step
        // Show a message that user needs to make a selection
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng chọn một tùy chọn')),
        );
        return;
      }

      // Xác định số lượng options cho bước tiếp theo
      int nextStepOptions = getOptionsCountForStep(state.currentStep + 1);
      
      emit(StepTripState(
        currentStep: state.currentStep + 1,
        isSelected: List.generate(nextStepOptions, (_) => false),
      ));
    } else if (state.currentStep == totalSteps - 1) {
      // Check if budget is selected before proceeding to review
      bool hasBudgetSelection = state.isSelected.contains(true);
      if (!hasBudgetSelection) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng chọn ngân sách')),
        );
        return;
      }
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewSummary(),
        ),
      );
    }
  }

  void preStep(BuildContext context) {
    if (state.currentStep > 0) {
      // Xác định số lượng options cho bước trước đó
      int prevStepOptions = getOptionsCountForStep(state.currentStep - 1);
      
      emit(StepTripState(
        currentStep: state.currentStep - 1,
        isSelected: List.generate(prevStepOptions, (_) => false),
      ));
    } else {
      Navigator.pop(context);
    }
  }

  void toggleSelection(int index) {
    if (index < 0 || index >= state.isSelected.length) {
      print('Invalid index: $index, max length: ${state.isSelected.length}');
      return;
    }

    final updatedSelection = List<bool>.filled(state.isSelected.length, false);
    updatedSelection[index] = true;

    emit(StepTripState(
      currentStep: state.currentStep,
      isSelected: updatedSelection,
    ));
  }

  bool isStepSelected(int index) {
    if (index < 0 || index >= state.isSelected.length) return false;
    return state.isSelected[index];
  }

  int getOptionsCountForStep(int step) {
    switch (step) {
      case 0: // Group options
        return 4;
      case 1: // Date picker
        return 1;
      case 2: // Budget options
        return 4;
      default:
        return 4;
    }
  }
}