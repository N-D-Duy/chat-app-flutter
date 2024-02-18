import 'package:chat_app_flutter/features/presentation/ui/main/home/find_select_contact/find_contact_list.dart';
import 'package:flutter/material.dart';

class SearchBarContact extends StatelessWidget {
  const SearchBarContact({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, FindContactList.routeName);
        },
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), // Border tròn
            border: Border.all(color: Colors.grey), // Viền xám
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8.0),
                Text('Search...'),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
