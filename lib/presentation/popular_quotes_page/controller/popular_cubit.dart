import 'package:dailyquotes/core/di/injection.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';

import 'package:dailyquotes/presentation/today_quote_page/controller/today_quotes_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/globales.dart';
import 'popular_states.dart';

class PopularCubit extends Cubit<PopularStates> {
  late QuoteEntity todayQuote;
  PopularCubit() : super(PopularInitialState());
  static PopularCubit get(context) => BlocProvider.of(context);

  List<QuoteEntity> popularQuotes = [];

  getPopularQuotes() async {
    emit(GetPopularLoadingState());

    final res = await locators.get<QuoteRepo>().getFavQuotes();
    if (res.isSuccess) {
      popularQuotes = res.data!;

      emit(GetPopularSucessState());
    } else {
      emit(GetPopularErrorState(onError.toString()));
    }
  }

  removeFromPopular(QuoteEntity quote) async {
    emit(
      RemoveFromPopularLoadingState(),
    );

    final res = await locators.get<QuoteRepo>().removeFromFav(quote.quote);
    if (res.isSuccess) {
      if (quote.quote == todayQuote.quote) {
        removeTodayFromPopular();
      } else {
        getPopularQuotes();
        emit(
          RemoveFromPopularSuccessState(),
        );
      }
    } else {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
    }
  }

  getTodayQuote(BuildContext context) async {
    todayQuote = context.read<TodayQuoteCubit>().todayQuote;
  }

  removeTodayFromPopular() async {
    todayQuote.fav = false;

    final res = await locators.get<QuoteRepo>().updateTodayQuote(todayQuote);
    if (res.isSuccess) {
      todayQuote = res.data!;
      emit(RemoveFromPopularSuccessState());

      getPopularQuotes();
    } else {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
    }
  }

  shareQuote(QuoteEntity quote) async {
    try {
      await Share.share(
        '“${quote.quote}”\n\n- ${quote.author}\n\n\n$sharingMyGit',
      );
    } catch (e) {
      emit(SharingQuoteErrorState(e.toString()));
    }
  }
}
