import 'package:dailyquotes/core/di/injection.dart';
import 'package:dailyquotes/domain/usecases/add_quote_to_popular_usecase.dart';
import 'package:dailyquotes/domain/usecases/remove_quote_from_popular_usecase.dart';

import 'package:dailyquotes/domain/usecases/get_today_quote_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/globales.dart';

import '../../../domain/entity/quote_entity.dart';
import 'today_quotes_states.dart';

class TodayQuoteCubit extends Cubit<TodayQuoteStates> {
  GetTodayQuoteUsecase getTodayQuoteUsecase =
      locators.get<GetTodayQuoteUsecase>();
  AddQuoteToPopularUsecase addQuoteToPopularUsecase =
      locators.get<AddQuoteToPopularUsecase>();
  RemoveQuoteFromPopularUsecase removeQuoteFromPopularUsecase =
      locators.get<RemoveQuoteFromPopularUsecase>();

  TodayQuoteCubit() : super(TodayInitialState());
  late QuoteEntity _todayQuote;
  QuoteEntity get todayQuote => _todayQuote;
  getTodayQuote() async {
    emit(GetTodayQuoteLoadingState());

    final res = await getTodayQuoteUsecase.getTodayQuote();
    if (res.isSuccess) {
      _todayQuote = res.data!;
      emit(GetTodayQuoteSuccessState());
    } else {
      emit(GetTodayQuoteErrorState(res.errorMessage!));
    }
  }

  addToPopular() async {
    emit(
      AddToPopularLoadingState(),
    );

    final res =
        await addQuoteToPopularUsecase.addQuoteToPopular(_todayQuote, true);
    if (res.isSuccess) {
      _todayQuote = res.data!;
      emit(AddToPopularSuccessState());
    } else {
      emit(AddToPopularErrorState(res.errorMessage!));
    }
  }

  removeFromPopular() async {
    emit(
      RemoveFromPopularLoadingState(),
    );

    final res = await removeQuoteFromPopularUsecase.removeQuoteFromPopular(
      _todayQuote,
      true,
    );
    if (res.isSuccess) {
      _todayQuote = res.data!;
      emit(RemoveFromPopularSuccessState());
    } else {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
    }
  }

  shareQuote() async {
    try {
      await Share.share(
        '“${_todayQuote.quote}”\n\n- ${_todayQuote.author}\n\n\n$sharingMyGit',
      );
    } catch (e) {
      emit(SharingQuoteErrorState(e.toString()));
    }
  }
}
