import 'package:flutter/material.dart';

class StepSecond extends StatefulWidget {
  const StepSecond({super.key});

  @override
  _StepSecondState createState() => _StepSecondState();
}

class _StepSecondState extends State<StepSecond> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedDate == null
                  ? 'No date selected!'
                  : 'Selected date: ${selectedDate!.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}
