import 'package:flutter/material.dart';
import '../../../../core/enums/enums.dart';
import '../../../widgets/card_step.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(step1.length, (index) {
        final data = step1[index];
        return CardStep(
          title: data["title"]!,
          subtitle: data["subtitle"]!,
          index: index,
        );
      }),
    );
  }
}
