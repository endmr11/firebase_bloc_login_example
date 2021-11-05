part of 'signin_bloc.dart';

class SigninState extends Equatable {
  final String userName;
  final String userSurname;
  final String userEmail;
  final String notificationToken;
  final bool loggedIn;

  const SigninState(
      {required this.userName,
      required this.userSurname,
      required this.userEmail,
      required this.notificationToken,
      required this.loggedIn});

  @override
  List<Object> get props => [userName, userSurname, userEmail, loggedIn];
}
