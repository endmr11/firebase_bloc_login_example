import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_bloc_login_example/bloc/detail_bloc.dart';
import 'package:firebase_bloc_login_example/bloc/signin_bloc.dart';
import 'package:firebase_bloc_login_example/data/database.dart';
import 'package:firebase_bloc_login_example/helpers/auth_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream? notesStream;
  String? userName;
  String? userSurname;
  String? userEmail;
  String? notificationToken;
  getUserInfo() async {
    userName = await AuthHelper.getUserNameSharedPreference();
    userSurname = await AuthHelper.getUserSurnameSharedPreference();
    userEmail = await AuthHelper.getUserEmailSharedPreference();
    notificationToken = await AuthHelper.getNotificationTokenSharedPreference();

    BlocProvider.of<SigninBloc>(context)
        .setLoginUser(userName!, userSurname!, userEmail!, notificationToken!);

    getByEmailNotes();
  }

  getByEmailNotes() async {
    databaseMethods.getByEmailNotes(userEmail!).then(
      (value) {
        setState(() {
          notesStream = value;
        });
      },
    );
    getByDocIdTokenUpdate();
  }

  getByDocIdTokenUpdate() async {
    QuerySnapshot userInfoSnapshot =
        await databaseMethods.getUserInfo(userEmail!);
    var docId = userInfoSnapshot.docs[0].id;

    Map<String, dynamic> dataMap = {
      "email": userEmail,
      "name": userName,
      "surname": userSurname,
      "notification_token": notificationToken,
    };
    databaseMethods.getByDocIdTokenUpdate(dataMap, docId);
  }

  delNote(id) async {
    databaseMethods.delNote(id);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    getUserInfo();

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        // ignore: avoid_print
        print('ON MESSAGEOPENED APP: Tıklayıp Uygulamayı Bildirimden Açtın!');

        if (message.data["sayfa"] == "eren") {
          Navigator.pushNamed(context, "/profileView");
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      debugPrint(" AppLifecycleState = Durdu (Home Page)");
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint(" AppLifecycleState = Devam Ediyor (Home Page)");
    }
    if (state == AppLifecycleState.inactive) {
      debugPrint(" AppLifecycleState = İnaktif (Home Page)");
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
        title: const Text("Anasayfa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/profileView");
            },
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: notesStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.data != null
              ? snapshot.data.docs.length > 0
                  ? ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            BlocProvider.of<DetailBloc>(context).setNoteDetail(
                              snapshot.data.docs[index]["note"],
                            );
                            Navigator.pushNamed(context, "/noteDetailView");
                          },
                          onLongPress: () =>
                              delNote(snapshot.data.docs[index].id),
                          title: Text(
                            snapshot.data.docs[index]["note"],
                            style: TextStyle(
                              color: snapshot.data.docs[index]["isDone"]
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data.docs[index]["email"],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              var docId = snapshot.data.docs[index].id;
                              // ignore: avoid_print
                              print("Document ID" + docId);
                              Map<String, dynamic> dataMap = {
                                "email": snapshot.data.docs[index]["email"],
                                "isDone": !snapshot.data.docs[index]["isDone"],
                                "note": snapshot.data.docs[index]["note"],
                              };
                              databaseMethods.getByDocIdDoneUpdate(
                                  dataMap, docId);
                            },
                            icon: Icon(
                              snapshot.data.docs[index]["isDone"]
                                  ? Icons.check
                                  : Icons.remove,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("Not Yok!"),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addNoteView");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
