import 'package:dailyquotes/core/Di/injection.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/model/services/Network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/globales.dart';
import 'todayStates.dart';

class TodayCubit extends Cubit<TodayStates> {
  TodayCubit() : super(TodayInitialState());
  static TodayCubit get(context) => BlocProvider.of(context);

  getTodayQuote() {
    emit(GetTodayQuoteLoadingState());
    if (CacheHelper.containsKey('date')) {
      DateTime date = DateTime.parse(CacheHelper.getData(key: 'date'));
      Duration duration = DateTime.now().difference(date);
      print('eeeeeeeeeee $date');
      print('eeeeeeeeeee ${DateTime.now()}');

      print('eeeeeeeeeee ${duration.inDays}');
      print('eeeeeeeeeee $duration');
      //if same day
      // if (date.difference(DateTime.now()).inDays != 0) {
      if (DateTime.now().isAfter(date) && DateTime.now().day > date.day) {
        print('finalllyyyyyy');
        locators.get<IReqRepo>().reqTodayQuote().then((value) {
          locators.get<IReqRepo>().updateTodayQuote(value).then((value) {
            todayQuote = value;
            emit(GetTodayQuoteSuccessState());
          });
        }).catchError((onError) {
          emit(
            GetTodayQuoteErrorState(
              onError.toString(),
            ),
          );
        });
      }
      //same day get quote from cache
      else {
        print('Same Day get quote from local database');
        locators.get<IReqRepo>().getTodayQuote().then((value) {
          todayQuote = value;

          emit(GetTodayQuoteSuccessState());
        }).catchError((error) {
          emit(GetTodayQuoteErrorState(onError.toString()));
        });
      }
    }
    //First scenario
    else {
      print('First scenario');

      locators.get<IReqRepo>().reqTodayQuote().then((value) {
        value.id = 1;
        locators.get<IReqRepo>().addTodayQuote(value).then((value) {
          todayQuote = value;
          emit(GetTodayQuoteSuccessState());
        }).catchError((error) {
          emit(GetTodayQuoteErrorState(onError.toString()));
        });
      }).catchError((onError) {
        emit(GetTodayQuoteErrorState(onError.toString()));
      });
    }
  }

  addToPopular(QuoteModel quote) {
    emit(
      AddToPopularLoadingState(),
    );
    quote.fav = true;
    locators.get<IReqRepo>().addFavQuote(quote).then((value) {
      ///we always add today's quote nothing else there :)
      locators.get<IReqRepo>().updateTodayQuote(quote).then((value) {
        quote = value;
        emit(AddToPopularSuccessState());
      }).catchError((error) {
        emit(AddToPopularErrorState(onError.toString()));
      });
    }).catchError((onError) {
      emit(AddToPopularErrorState(onError.toString()));
    });
  }

  removeFromPopular(QuoteModel quote) {
    emit(
      RemoveFromPopularLoadingState(),
    );
    quote.fav = false;

    ///we always remove today's quote nothing else there :)

    locators.get<IReqRepo>().removeFromFav(quote.quote).then((value) {
      locators.get<IReqRepo>().updateTodayQuote(quote).then((value) {
        quote = value;
        emit(RemoveFromPopularSuccessState());
      }).catchError((error) {
        emit(RemoveFromPopularErrorState(onError.toString()));
      });
    }).catchError((error) {
      emit(RemoveFromPopularErrorState(onError.toString()));
    });
  }

  /*  getQuoteByKey({
    required String keyword,
  }) async {
    await locators.get<IReqRepo>().reqWithKeyRepo(keyword: keyword);
  } */
}
