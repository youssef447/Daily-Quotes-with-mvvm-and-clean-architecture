import 'package:dailyquotes/core/di/injection.dart';

import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';
import 'package:dailyquotes/domain/usecases/update_today_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/globales.dart';
import '../../../domain/usecases/get_today_quote_usecase.dart';
import '../../../domain/usecases/remove_quote_from_popular_usecase.dart';
import 'popular_states.dart';

class PopularCubit extends Cubit<PopularStates> {
  GetTodayQuoteUsecase getTodayQuoteUsecase =
      locators.get<GetTodayQuoteUsecase>();
  UpdateTodayQuoteUseCase updateTodayQuoteUsecase =
      locators.get<UpdateTodayQuoteUseCase>();
  RemoveQuoteFromPopularUsecase removeQuoteFromPopularUsecase =
      locators.get<RemoveQuoteFromPopularUsecase>();
  PopularCubit() : super(PopularInitialState());
  static PopularCubit get(context) => BlocProvider.of(context);

  List<QuoteEntity> popularQuotes = [];

  getPopularQuotes() async {
    emit(GetPopularLoadingState());

    final res = await locators.get<QuoteRepo>().getFavQuotes();
    if (res.isError) {
      emit(GetPopularErrorState(res.errorMessage!));
    }
    popularQuotes = res.data!;

    emit(GetPopularSucessState());
  }

  removeFromPopular(QuoteEntity quote) async {
    emit(
      RemoveFromPopularLoadingState(),
    );

    final res =
        await removeQuoteFromPopularUsecase.removeQuoteFromPopular(quote);
    if (res.isError) {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
      return;
    }

    final todayQuote = await getTodayQuote();
    if (quote.quote == todayQuote?.quote) {
      final res = await removeTodayQuote(todayQuote!);
      if (res) {
        getPopularQuotes();
      }
    } else {
      //update popular quotes
      getPopularQuotes();
      emit(RemoveFromPopularSuccessState());
    }
  }

  Future<QuoteEntity?> getTodayQuote() async {
    final res = await getTodayQuoteUsecase.getTodayQuote();
    if (res.isError) {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
      return null;
    }

    return res.data!;
  }

  Future<bool> removeTodayQuote(QuoteEntity quote) async {
    quote.toggleFav(false);
    final res = await updateTodayQuoteUsecase.updateTodayQuote(quote);
    if (res.isError) {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
      return false;
    }

    return true;
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
