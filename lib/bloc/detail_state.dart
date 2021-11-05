part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final String detailText;
  const DetailState({required this.detailText});

  @override
  List<Object> get props => [detailText];
}
