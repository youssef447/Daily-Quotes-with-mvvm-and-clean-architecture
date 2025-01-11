import 'package:dailyquotes/core/di/injection.dart';

import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';
import 'package:dailyquotes/domain/usecases/update_today_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/domain/usecases/get_today_quote_usecase.dart';
import 'package:dailyquotes/domain/usecases/remove_quote_from_popular_usecase.dart';
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
    emit(RemoveFromPopularLoadingState());

    final res =
        await removeQuoteFromPopularUsecase.removeQuoteFromPopular(quote);
    if (res.isError) {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
      return;
    }

    //update popular quotes
    getPopularQuotes();
    emit(RemoveFromPopularSuccessState());
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
