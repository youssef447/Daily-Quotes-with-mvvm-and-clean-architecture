import 'package:dailyquotes/core/di/injection.dart';
import 'package:dailyquotes/data/Models/quoteModel.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:dailyquotes/features/my_quotes_page/presentation/controller/my_quotes_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/utils.dart';

class MyQuotesCubit extends Cubit<MyQuotesStates> {
  MyQuotesCubit() : super(MyQuotesInitialState());

  static MyQuotesCubit get(context) => BlocProvider.of(context);
  List<QuoteModel> myQuotes = [];

  getMyQuotes() {
    emit(GetMyQuotesLoadingState());
    locators.get<QuoteRepoImp>().getMyQuotes().then((value) {
      myQuotes = value;
      emit(GetMyQuotesSuccessState());
    }).catchError((onError) {
      emit(GetMyQuotesErrorState(onError.toString()));
    });
  }

  removeMyQuote(int id) {
    emit(RemoveMyQuoteLoadingState());
    locators.get<QuoteRepoImp>().deleteMyQuote(id).then((value) {
      emit(RemoveMyQuoteSuccessState());
      getMyQuotes();
    }).catchError((onError) {
      emit(RemoveMyQuoteErrorState(onError.toString()));
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
