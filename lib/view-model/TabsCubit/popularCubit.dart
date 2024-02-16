import 'package:dailyquotes/core/Di/injection.dart';
import 'package:dailyquotes/model/repositories/iRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/globales.dart';
import '../../model/Models/quoteModel.dart';
import 'popularStates.dart';

class PopularCubit extends Cubit<PopularStates> {
  PopularCubit() : super(PopularInitialState());
  static PopularCubit get(context) => BlocProvider.of(context);

  List<QuoteModel> popularQuotes = [];

  getPopularQuotes() {
    emit(GetPopularLoadingState());

    locators.get<IRepo>().getFavQuotes().then((value) {
      popularQuotes = value;
      
      emit(GetPopularSucessState());
    }).catchError((onError) {
      emit(GetPopularErrorState(onError.toString()));
    });
  }

  removeFromPopular(QuoteModel quote) {
    emit(
      RemoveFromPopularLoadingState(),
    );
    locators.get<IRepo>().removeFromFav(quote.quote).then((value) {
      if (quote.quote == todayQuote.quote) {
        todayQuote.fav = false;

        locators.get<IRepo>().updateTodayQuote(todayQuote).then((value) {
          todayQuote = value;
          emit(RemoveFromPopularSuccessState());

          getPopularQuotes();
        }).catchError((error) {
          emit(RemoveFromPopularErrorState(onError.toString()));
        });
      } else {
        getPopularQuotes();
        emit(
          RemoveFromPopularSuccessState(),
        );
      }
    }).catchError((error) {
      emit(RemoveFromPopularErrorState(onError.toString()));
    });
  }

  shareQuote(QuoteModel quote) async {
    try {
      await Share.share(
        '“${quote.quote}”\n\n- ${quote.author}\n\n\n$sharingMyGit',
      );
    } catch (e) {
      emit(SharingQuoteErrorState(e.toString()));
    }
  }
}
