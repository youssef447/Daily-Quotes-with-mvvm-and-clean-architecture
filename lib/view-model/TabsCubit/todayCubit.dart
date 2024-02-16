import 'package:dailyquotes/core/Di/injection.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/model/repositories/iRepo.dart';
import 'package:dailyquotes/model/services/Network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/globales.dart';
import 'todayStates.dart';

class TodayCubit extends Cubit<TodayStates> {
  TodayCubit() : super(TodayInitialState());
  static TodayCubit get(context) => BlocProvider.of(context);

  getTodayQuote() {
    emit(GetTodayQuoteLoadingState());
    if (CacheHelper.containsKey('date')) {
      DateTime date = DateTime.parse(CacheHelper.getData(key: 'date'));

      //if same day
      // if (date.difference(DateTime.now()).inDays != 0) {
      if (DateTime.now().isAfter(date) && DateTime.now().day > date.day) {
        locators.get<IRepo>().reqTodayQuote().then((value) {
          locators.get<IRepo>().updateTodayQuote(value).then((value) {
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
        locators.get<IRepo>().getTodayQuote().then((value) {
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

      locators.get<IRepo>().reqTodayQuote().then((value) {
        value.id = 1;
        locators.get<IRepo>().addTodayQuote(value).then((value) {
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
    locators.get<IRepo>().addFavQuote(quote).then((value) {
      ///we always add today's quote nothing else there :)
      locators.get<IRepo>().updateTodayQuote(quote).then((value) {
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

    locators.get<IRepo>().removeFromFav(quote.quote).then((value) {
      locators.get<IRepo>().updateTodayQuote(quote).then((value) {
        quote = value;
        emit(RemoveFromPopularSuccessState());
      }).catchError((error) {
        emit(RemoveFromPopularErrorState(onError.toString()));
      });
    }).catchError((error) {
      emit(RemoveFromPopularErrorState(onError.toString()));
    });
  }

  shareQuote() async {
    try {
      await Share.share(
        '“${todayQuote.quote}”\n\n- ${todayQuote.author}\n\n\n$sharingMyGit',
      );
    } catch (e) {
      emit(SharingQuoteErrorState(e.toString()));
    }
  }
  
}
