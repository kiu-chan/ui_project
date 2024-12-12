class StepTripState {
  final int currentStep;
  final List<bool> isSelected;

  StepTripState({
    required this.currentStep,
    required this.isSelected,
  });

  StepTripState copyWith({
    int? currentStep,
    List<bool>? isSelected,
  }) {
    return StepTripState(
      currentStep: currentStep ?? this.currentStep,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}