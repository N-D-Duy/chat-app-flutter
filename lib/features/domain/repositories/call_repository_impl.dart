import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:chat_app_flutter/features/data/datasources/call/call_remote_data_source.dart';
import 'package:chat_app_flutter/features/data/repositories/call_repository.dart';
import 'package:chat_app_flutter/features/domain/models/call_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

class CallRepositoryImpl extends CallRepository {
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl(this.remoteDataSource);

  @override
  Stream<CallModel> get callStream => remoteDataSource.callStream;

  @override
  Stream<List<CallModel>> getCallHistory() => remoteDataSource.getCallHistory();

  @override
  Future<Either<Failure, void>> makeCall(BuildContext context,
      {required String receiverId,
      required String receiverName,
      required String receiverPic}) async {
    try {
      final result = await remoteDataSource.makeCall(context,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<void> endCall({required String callerId, required String receiverId}) {
    return remoteDataSource.endCall(callerId: callerId, receiverId: receiverId);
  }
}
