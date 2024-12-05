import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/step_screen_cubit/step_state.dart';

class StepCubit extends Cubit<StepTripState> {
  StepCubit()
      : super(
          StepTripState(
            currentStep: 0,
            isSelected: List.generate(5, (_) => false),
          ),
        );

  final int totalSteps = 3;

  void nextStep() {
    if (state.currentStep < totalSteps - 1) {
      emit(StepTripState(
          currentStep: state.currentStep + 1, isSelected: state.isSelected));
    }
  }

  void preStep(BuildContext context) {
    if (state.currentStep > 0) {
      emit(StepTripState(
          currentStep: state.currentStep - 1, isSelected: state.isSelected));
    }
    if (state.currentStep == 0) {
      Navigator.pop(context);
    }
  }

  void toggleSelection(int index) {
    final updatedSelection = List<bool>.from(state.isSelected);
    for (int i = 0; i < updatedSelection.length; i++) {
      updatedSelection[i] = i == index;
    }

    emit(state.copyWith(isSelected: updatedSelection));
  }

  bool isStepSelected(int index) {
    return state.isSelected[index];
  }
}
