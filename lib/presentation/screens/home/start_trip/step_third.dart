import 'package:flutter/material.dart';

import '../../../../core/enums/enums.dart';
import '../../../widgets/card_step.dart';

class StepThird extends StatelessWidget {
  const StepThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(step3.length, (index) {
        final data = step3[index];
        return CardStep(
          title: data["title"]!,
          subtitle: data["subtitle"]!,
          index: index,
        );
      }),
    );
  }
}
