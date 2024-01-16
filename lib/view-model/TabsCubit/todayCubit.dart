import 'dart:convert';

import 'package:dailyquotes/core/Di/injection.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/model/services/Network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todayStates.dart';

class TodayCubit extends Cubit<TodayStates> {
  TodayCubit() : super(TodayInitialState());
  static TodayCubit get(context) => BlocProvider.of(context);

  QuoteModel? quote;
  bool fav = false;

  getTodayQuote() {
    emit(GetTodayQuoteLoadingState());
    if (CacheHelper.containsKey('date')) {
      DateTime date = DateTime.parse(CacheHelper.getData(key: 'date'));
      //if same day
      if (date.difference(DateTime.now()).inDays != 0) {
        locators.get<IReqRepo>().reqTodayRepo().then((value) {
          quote = value;

          emit(GetTodayQuoteSuccessState());
        }).catchError((onError) {
          emit(GetTodayQuoteErrorState(onError.toString()));
        });
      }
      //same day get quote from cache
      else {
        print('eeeeeeeeeeeeeeeeeeeeeeeeh');
        print(json.decode(CacheHelper.getData(key: 'today')));

        quote = QuoteModel.fromJson(
          json.decode(
            CacheHelper.getData(key: 'today'),
          ),
        );
        emit(GetTodayQuoteSuccessState());
      }
    } //First scenario
    else {
      locators.get<IReqRepo>().reqTodayRepo().then((value) {
        quote = value;

        emit(GetTodayQuoteSuccessState());
      }).catchError((onError) {
        emit(GetTodayQuoteErrorState(onError.toString()));
      });
    }
  }

  addToPopular(QuoteModel quote) {
    emit(
      AddToPopularLoadingState(),
    );
    locators
        .get<IReqRepo>()
        .addFavToTable(model: quote)
        .then((value) {
          fav=true;
          emit(AddToPopularSuccessState());
        })
        .catchError((onError) {
      emit(AddToPopularErrorState(onError.toString()));
    });
  }

  /*  getQuoteByKey({
    required String keyword,
  }) async {
    await locators.get<IReqRepo>().reqWithKeyRepo(keyword: keyword);
  } */
}
