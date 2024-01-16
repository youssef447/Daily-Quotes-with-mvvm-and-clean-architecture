import 'package:dailyquotes/core/Di/injection.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/Entities/quote.dart';
import 'popularStates.dart';

class PopularCubit extends Cubit<PopularStates> {
  PopularCubit() : super(PopularInitialState());
  static PopularCubit get(context) => BlocProvider.of(context);

  List<Quote> popularQuotes = [];

  getPopularQuotes() {
    emit(GetPopularLoadingState());

    locators.get<IReqRepo>().getFavFromTable().then((value) {
      popularQuotes = value;
      emit(GetPopularSucessState());
    }).catchError((onError) {
      emit(GetPopularErrorState(onError.toString()));
    });
  }
}
