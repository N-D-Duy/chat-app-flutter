import 'package:chat_app_flutter/features/presentation/bloc/contacts/contacts_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/general/contacts/contacts_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              if (state is GetAllContactsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetAllContactsSuccess) {
                return ListView.builder(
                  itemCount: state.contacts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final contact = state.contacts[index];
                    return ContactsCard(
                      image: contact.profileImage,
                      name: contact.userName,
                    );
                  },
                );
              } else if (state is GetAllContactsError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('No contacts'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}