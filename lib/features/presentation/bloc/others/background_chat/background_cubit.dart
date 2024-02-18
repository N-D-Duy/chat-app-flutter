import 'package:chat_app_flutter/features/data/datasources/others/change_background_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'background_state.dart';

class BackgroundCubit extends Cubit<BackgroundState> {
  BackgroundCubit() : super(const InitialBackground([Colors.white, Colors.white])){
    loadBackgroundColor();
  }
  Future<void> loadBackgroundColor() async {
    // Lấy giá trị backgroundColor từ SharedPreferences
    emit(ChangeBackgroundLoading());
    try{
      final backgroundColor = await getBackground();
      emit(GetBackgroundSuccess(backgroundColor));
    } catch (e) {
      emit(BackgroundError(e.toString()));
    }
  }

}

