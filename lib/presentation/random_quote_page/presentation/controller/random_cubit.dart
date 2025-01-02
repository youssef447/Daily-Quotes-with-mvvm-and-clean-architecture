import 'package:dailyquotes/core/di/injection.dart';

import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/globales.dart';
import 'random_states.dart';

class RandomCubit extends Cubit<RandomStates> {
  RandomCubit() : super(RandomInitialState());
  static RandomCubit get(context) => BlocProvider.of(context);

  QuoteEntity? quote;

  getRandomQuote() async {
    emit(GetRandomLoadingState());
    final res = await locators.get<QuoteRepo>().getRandomQuote();
    if (res.isSuccess) {
      quote = res.data;
      emit(GetRandomSuccessState());
    } else {
      emit(GetRandomErrorState(res.errorMessage!));
    }
  }

  addToPopular() async {
    emit(AddToPopularLoadingState());
    quote!.fav = true;
    final res = await locators.get<QuoteRepo>().addFavQuote(quote!);
    if (res.isSuccess) {
      emit(AddToPopularSuccessState());
    } else {
      emit(AddToPopularErrorState(res.errorMessage!));
    }
  }

  removeFromPopular() async {
    emit(RemoveFromPopularLoadingState());
    quote!.fav = false;
    final res = await locators.get<QuoteRepo>().removeFromFav(quote!.quote);
    if (res.isSuccess) {
      emit(RemoveFromPopularSuccessState());
    } else {
      emit(RemoveFromPopularErrorState(res.errorMessage!));
    }
  }

  shareQuote() async {
    try {
      await Share.share(
        '“${quote!.quote}”\n\n- ${quote!.author}\n\n\n$sharingMyGit',
      );
    } catch (e) {
      emit(SharingQuoteErrorState(e.toString()));
    }
  }
}
