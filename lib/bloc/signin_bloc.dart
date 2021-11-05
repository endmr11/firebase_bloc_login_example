import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_bloc_login_example/helpers/auth_helper.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(SigninState initialState) : super(initialState);

  String? userName;
  String? userSurname;
  String? userEmail;
  String? notificationToken;
  bool? loggedIn;
  @override
  //Etkinliğin gerçekleştirilmesi
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    SigninState newState;
    userName = event.userName;
    userSurname = event.userSurname;
    userEmail = event.userEmail;
    notificationToken = event.notificationToken;
    loggedIn = event.loggedIn;
    newState = SigninState(
      userName: userName!,
      userSurname: userSurname!,
      userEmail: userEmail!,
      notificationToken: notificationToken!,
      loggedIn: loggedIn!,
    );
    yield newState;
  }

  void saveLoginUser(String userName, String userSurname, String userEmail,
      String notificationToken) {
    // ignore: avoid_print
    print("Kullanıcı Giriş Yaptı");
    AuthHelper.saveUserNameSharedPreference(userName);
    AuthHelper.saveUserSurnameSharedPreference(userSurname);
    AuthHelper.saveUserEmailSharedPreference(userEmail);
    AuthHelper.saveNotificationTokenSharedPreference(notificationToken);
    AuthHelper.saveUserLoggedInSharedPreference(true);
    add(
      SigninEvent(
        userName: userName,
        userSurname: userSurname,
        userEmail: userEmail,
        notificationToken: notificationToken,
        loggedIn: true,
      ),
    );
  }

  void setLoginUser(String userName, String userSurname, String userEmail,
      String notificationToken) {
    // ignore: avoid_print
    print("Kullanıcı Henüz Programı Sonlandırmadı");
    add(
      SigninEvent(
        userName: userName,
        userSurname: userSurname,
        userEmail: userEmail,
        notificationToken: notificationToken,
        loggedIn: true,
      ),
    );
  }
}
