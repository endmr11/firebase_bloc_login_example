import 'package:firebase_bloc_login_example/bloc/signin_bloc.dart';
import 'package:firebase_bloc_login_example/data/auth.dart';
import 'package:firebase_bloc_login_example/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with WidgetsBindingObserver {
  AuthMethods authMethods = AuthMethods();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      debugPrint(" AppLifecycleState = Durdu (Profile Page)");
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint(" AppLifecycleState = Devam Ediyor (Profile Page)");
    }
    if (state == AppLifecycleState.inactive) {
      debugPrint(" AppLifecycleState = İnaktif (Profile Page)");
    }
  }

  @override
  void dispose() {
    super.dispose();
    // ignore: avoid_print
    print("Dispose çalıştı");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authMethods.signOut();
              AuthHelper.deleteSharedPreference();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/signinView");
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<SigninBloc, SigninState>(
          bloc: BlocProvider.of<SigninBloc>(context),
          builder: (context, SigninState state) {
            return Column(
              children: [
                Text("Kullanıcı Adı: ${state.userName}"),
                Text("Kullanıcı Adı: ${state.userSurname}"),
                Text("Mail: ${state.userEmail}"),
                Text("Token: ${state.notificationToken}"),
                Text("Giriş: ${state.loggedIn}"),
              ],
            );
          },
        ),
      ),
    );
  }
}
