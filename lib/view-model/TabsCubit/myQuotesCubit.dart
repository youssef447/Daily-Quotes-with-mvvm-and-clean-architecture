import 'package:dailyquotes/core/Di/injection.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/view-model/TabsCubit/myQuotesStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/globales.dart';

class MyQuotesCubit extends Cubit<MyQuotesStates> {
  MyQuotesCubit() : super(MyQuotesInitialState());

  static MyQuotesCubit get(context) => BlocProvider.of(context);
  List<QuoteModel> myQuotes = [];

  getMyQuotes() {
    emit(GetMyQuotesLoadingState());
    locators.get<IReqRepo>().getMyQuotes().then((value) {
      myQuotes = value;
      emit(GetMyQuotesSuccessState());
    }).catchError((onError) {
      emit(GetMyQuotesErrorState(onError.toString()));
    });
  }

  removeMyQuote(int id) {
    emit(RemoveMyQuoteLoadingState());
    locators.get<IReqRepo>().deleteMyQuote(id).then((value) {
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
