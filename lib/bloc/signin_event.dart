part of 'signin_bloc.dart';

class SigninEvent extends Equatable {
  final String userName;
  final String userSurname;
  final String userEmail;
  final String notificationToken;
  final bool loggedIn;
  final DateTime timestamp;

  SigninEvent(
      {required this.userName,
      required this.userSurname,
      required this.userEmail,
      required this.notificationToken,
      required this.loggedIn,
      DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object> get props => [
        userName,
        userSurname,
        userEmail,
        loggedIn,
        timestamp,
      ];
}
