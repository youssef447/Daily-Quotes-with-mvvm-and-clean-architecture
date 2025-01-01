import 'package:dailyquotes/core/di/injection.dart';
import 'package:dailyquotes/features/home_page/data/models/quoteModel.dart';
import 'package:dailyquotes/features/home_page/data/repositories/quote_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/globales.dart';
import 'random_states.dart';

class RandomCubit extends Cubit<RandomStates> {
  RandomCubit() : super(RandomInitialState());
  static RandomCubit get(context) => BlocProvider.of(context);

  QuoteModel? quote;

  getRandomQuote() {
    emit(GetRandomLoadingState());
    locators.get<QuoteRepo>().getRandomQuote().then((value) {
      quote = value;
      emit(GetRandomSuccessState());
    }).catchError((onError) {
      emit(GetRandomErrorState(onError.toString()));
    });
  }

  addToPopular() {
    emit(AddToPopularLoadingState());
    quote!.fav = true;
    locators.get<QuoteRepo>().addFavQuote(quote!).then((value) {
      emit(AddToPopularSuccessState());
    }).catchError((onError) {
      emit(AddToPopularErrorState(onError.toString()));
    });
  }

  removeFromPopular() {
    emit(RemoveFromPopularLoadingState());
    quote!.fav = false;
    locators.get<QuoteRepo>().removeFromFav(quote!.quote).then((value) {
      emit(RemoveFromPopularSuccessState());
    }).catchError((error) {
      emit(RemoveFromPopularErrorState(onError.toString()));
    });
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
