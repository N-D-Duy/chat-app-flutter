import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/presentation/cubits/user_cubits/user_cubit.dart';
import 'package:chat_app_flutter/features/presentation/cubits/user_cubits/user_state.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/components/header/item_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatefulWidget {
  final String uid;
  const HomeHeader({super.key, required this.uid});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String get uid => widget.uid;
  @override
  Widget build(BuildContext context) {
    if (uid.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).getUsers();
      BlocProvider.of<UserCubit>(context).getProfiles();
    }
    return SizedBox(
        height: 200,
        child: Stack(children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.search, color: Colors.white, size: 30),
                  const Text(
                    'Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is ProfileLoadingState ||
                          state is ProfileErrorState) {
                        return const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                        );
                      } else if (state is ProfileLoadedState) {
                        Profile profile = state.profile.firstWhere(
                            (element) => element.uid == uid,
                            orElse: () => Profile.defaultConstructor());
                        if (profile.avatar != null) {
                          return CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(profile.avatar!),
                          );
                        } else {
                          return const CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/default_avatar.jpg'),
                          );
                        }
                      } else {
                        return const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 0,
            top: 80,
            child: SizedBox(
              height: 100,
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoadedState) {
                    List<Profile> profiles = state.profile;

                    // Get the profile of the current user
                    //and put it at the first index
                    List<Profile> specificProfile = [];
                    List<Profile> remainingProfiles = [];

                    for (var profile in profiles) {
                      if (profile.uid == uid) {
                        specificProfile.add(profile);
                      } else {
                        remainingProfiles.add(profile);
                      }
                    }

                    // Concatenate the two lists
                    List<Profile> reorderedProfiles =
                        specificProfile + remainingProfiles;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: reorderedProfiles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (index != 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            profile: reorderedProfiles[index],
                                            uid: uid,
                                          )));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:
                                ItemStatus(profile: reorderedProfiles[index]),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ]));
  }
}
