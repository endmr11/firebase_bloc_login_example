part of 'detail_bloc.dart';

class DetailEvent extends Equatable {
  final String detailText;
  final DateTime timestamp;

  DetailEvent({required this.detailText, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object> get props => [detailText, timestamp];
}
