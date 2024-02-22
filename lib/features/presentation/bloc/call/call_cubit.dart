import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/models/call_model.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final usecase = di<AppUseCases>;

  CallCubit() : super(CallInitial());

  Stream<CallModel> get callStream => usecase().call.callStream;

  Stream<List<CallModel>> getCallHistory() => usecase().call.getCallHistory();

  Future<void> makeCall(BuildContext context,
      {required String receiverId,
      required String receiverName,
      required String receiverPic,
      required bool isGroupChat}) async {
    if (!isGroupChat) {
      final result = await usecase().call.makeCall(context,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic);
      result.fold(
        (l) => emit(CallError(l.message)),
        (r) => emit(MakeCallSuccess()),
      );
    }
  }

  Future<void> endCall({required String callerId, required String receiverId}) {
    emit(CallEnded());
    return usecase().call.endCall(callerId: callerId, receiverId: receiverId);
  }
}
