import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/repositories/call_repository.dart';
import 'package:chat_app_flutter/features/domain/models/call_model.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class CallUseCase extends CallRepository {
  final CallRepository _callRepository;

  CallUseCase(this._callRepository);

  @override
  Stream<CallModel> get callStream => _callRepository.callStream;

  @override
  Future<void> endCall({required String callerId, required String receiverId}) {
      return _callRepository.endCall(
          callerId: callerId, receiverId: receiverId);
  }
  @override
  Stream<List<CallModel>> getCallHistory() => _callRepository.getCallHistory();

  @override
  Future<Either<Failure, void>> makeCall(BuildContext context,
      {required String receiverId,
      required String receiverName,
      required String receiverPic}) {

      return _callRepository.makeCall(context,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic);
  }
}
