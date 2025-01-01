import 'package:dailyquotes/core/di/injection.dart';
import 'package:dailyquotes/features/home_page/data/models/quoteModel.dart';
import 'package:dailyquotes/features/home_page/data/repositories/quote_repo.dart';
import 'package:dailyquotes/features/my_quotes_page/presentation/controller/my_quotes_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/globales.dart';

class MyQuotesPageCubit extends Cubit<MyQuotesPageStates> {
  MyQuotesPageCubit() : super(MyQuotesPageInitialState());

  static MyQuotesPageCubit get(context) => BlocProvider.of(context);
  List<QuoteModel> MyQuotesPage = [];

  getMyQuotesPage() {
    emit(GetMyQuotesPageLoadingState());
    locators.get<QuoteRepo>().getMyQuotesPage().then((value) {
      MyQuotesPage = value;
      emit(GetMyQuotesPageSuccessState());
    }).catchError((onError) {
      emit(GetMyQuotesPageErrorState(onError.toString()));
    });
  }

  removeMyQuote(int id) {
    emit(RemoveMyQuoteLoadingState());
    locators.get<QuoteRepo>().deleteMyQuote(id).then((value) {
      emit(RemoveMyQuotesPageuccessState());
      getMyQuotesPage();
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
