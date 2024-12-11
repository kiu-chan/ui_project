import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/data/models/Home/festival_model.dart';

import '../../presentation/widgets/custome_snackbar.dart';

class SavedFestivalsCubit extends Cubit<List<FestivalModel>> {
  SavedFestivalsCubit() : super([]);

  void toogleSave(BuildContext context, FestivalModel items) {
    bool isSaved;
    if (state.contains(items)) {
      emit(state.where((item) => item.image != items.image).toList());
      isSaved = false;
    } else {
      emit([...state, items]);
      isSaved = true;
    }
    final message = isSaved ? 'Đã lưu!' : 'Bỏ lưu!';
    customSnackBar(context, message);
  }
}
