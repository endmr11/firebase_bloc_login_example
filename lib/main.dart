import 'package:firebase_bloc_login_example/bloc/detail_bloc.dart';
import 'package:firebase_bloc_login_example/bloc/signin_bloc.dart';
import 'package:firebase_bloc_login_example/helpers/auth_helper.dart';
import 'package:firebase_bloc_login_example/views/add_note_view.dart';
import 'package:firebase_bloc_login_example/views/home_view.dart';
import 'package:firebase_bloc_login_example/views/note_detail_view.dart';
import 'package:firebase_bloc_login_example/views/profile_view.dart';
import 'package:firebase_bloc_login_example/views/signin_view.dart';
import 'package:firebase_bloc_login_example/views/signup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // ignore: avoid_print
  print(
      'ARKA PLAN MESAJ ID: Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  String? userName;
  String? userSurname;
  String? userEmail;
  String? notificationToken;
  bool? userIsLoggedIn;
  userName = await AuthHelper.getUserNameSharedPreference();
  userSurname = await AuthHelper.getUserSurnameSharedPreference();
  userEmail = await AuthHelper.getUserEmailSharedPreference();
  notificationToken = await AuthHelper.getNotificationTokenSharedPreference();
  userIsLoggedIn = await AuthHelper.getUserLoggedInSharedPreference();

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SigninBloc>(
          create: (BuildContext context) => SigninBloc(
            SigninState(
              userName: userName ?? "",
              userSurname: userSurname ?? "",
              userEmail: userEmail ?? "",
              notificationToken: notificationToken ?? "",
              loggedIn: userIsLoggedIn ?? false,
            ),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => DetailBloc(
            const DetailState(
              detailText: "",
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    AuthHelper.saveNotificationTokenSharedPreference(token!);
    // ignore: avoid_print
    print("NOTIFICATIONS TOKEN: $token");
  }

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          // ignore: avoid_print
          print("REMOTE MESSAGE ID: ${message.messageId}");
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // ignore: avoid_print
        print("MESSAGE ID: ${message.messageId}");
        if (notification != null && android != null && !kIsWeb) {
          if (BlocProvider.of<SigninBloc>(context).loggedIn ?? false) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  icon: 'launch_background',
                ),
              ),
            );
          } else {
            // ignore: avoid_print
            print("HESAP GİRİLMEDEN BİLDİRİM GELMEZ");
          }
        }
      },
    );
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      bloc: BlocProvider.of<SigninBloc>(context),
      builder: (context, SigninState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/homeView": (context) => const HomeView(),
            "/signinView": (context) => const SigninView(),
            "/signupView": (context) => const SignupView(),
            "/profileView": (context) => const ProfileView(),
            "/addNoteView": (context) => const AddNoteView(),
            "/noteDetailView": (context) => const NoteDetailView(),
          },
          initialRoute: state.loggedIn ? "/homeView" : "/signinView",
        );
      },
    );
  }
}
