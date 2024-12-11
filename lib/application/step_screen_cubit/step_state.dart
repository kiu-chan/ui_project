class StepTripState {
  final int currentStep;
  final List<bool> isSelected;

  StepTripState({
    required this.currentStep,
    required this.isSelected,
  });

  // Create a copy with updated fields for immutability
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
