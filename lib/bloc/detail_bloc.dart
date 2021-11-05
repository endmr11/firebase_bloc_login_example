import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(DetailState initialState) : super(initialState);

  String? detailText;

  @override
  //Etkinliğin gerçekleştirilmesi
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    DetailState newState;
    detailText = event.detailText;
    newState = DetailState(
      detailText: detailText!,
    );
    yield newState;
  }

  void setNoteDetail(String detailText) {
    // ignore: avoid_print
    print("Kullanıcı Detay Sayfasına Gitti");
    add(
      DetailEvent(
        detailText: detailText,
      ),
    );
  }
}
