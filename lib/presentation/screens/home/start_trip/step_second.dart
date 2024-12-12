import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:intl/intl.dart';
import 'package:ui_project/presentation/screens/home/start_trip/trip_data_manager.dart'; 

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
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
      // Lưu thông tin ngày đã chọn
      TripDataManager().setDate(DateFormat('dd/MM/yyyy').format(picked));
    });
  }
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
                  ? 'Chưa chọn ngày!' // No date selected message
                  : 'Ngày: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Chọn ngày',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
