import 'package:chat_app_flutter/features/presentation/ui/main/status/components/status_bar.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/status/components/status_list.dart';
import 'package:chat_app_flutter/features/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/status_model.dart';
import '../../../bloc/status/status_cubit.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const StatusAppBar(),
        body: BlocBuilder<StatusCubit, StatusState>(
          builder: (context, state) {
            return StreamBuilder<List<StatusModel>>(
                stream: context.read<StatusCubit>().getStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CustomLoading(
                        borderColor: Colors.grey,
                        backgroundColor: Colors.grey,
                        size: 30,
                        opacity: 0.5);
                  } else {
                    if (snapshot.data!.isNotEmpty) {
                      return StatusList(status: snapshot.data!);
                    } else {
                      return const Center(child: Text("Status Empty"));
                    }
                  }
                });
          },
        ));
  }
}
