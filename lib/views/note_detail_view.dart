import 'package:firebase_bloc_login_example/bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailView extends StatefulWidget {
  const NoteDetailView({Key? key}) : super(key: key);

  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detay",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<DetailBloc, DetailState>(
              bloc: BlocProvider.of<DetailBloc>(context),
              builder: (context, DetailState state) {
                return Text(
                  state.detailText,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
