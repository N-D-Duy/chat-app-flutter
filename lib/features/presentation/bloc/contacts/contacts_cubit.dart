import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final _useCases = di<AppUseCases>;
  ContactsCubit() : super(GetAllContactsInitial());
  Future<void> getAllContacts() async {
    emit(GetAllContactsLoading());
    try {
      final contacts = await _useCases().contacts.getAllContacts();
      contacts.fold(
        (error) => emit(GetAllContactsError(message: error.message)),
        (success) => emit(GetAllContactsSuccess(contacts: success)),
      );
    } catch (e) {
      emit(GetAllContactsError(message: e.toString()));
    }
  }
}
