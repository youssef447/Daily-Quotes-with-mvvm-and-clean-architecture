import 'package:dailyquotes/features/home_page/data/models/quoteModel.dart';
import 'package:dailyquotes/features/add_edit_quote/presentation/controller/add_edit_quote_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import 'package:dailyquotes/features/home_page/data/repositories/quote_repo.dart';

class AddEditQuoteCubit extends Cubit<AddEditQuoteStates> {
  AddEditQuoteCubit() : super(AddEditQuoteInitialState());

  static AddEditQuoteCubit get(context) => BlocProvider.of(context);

  addMyQuote({required String quote, required String author}) {
    emit(AddMyQuoteLoadingState());
    QuoteModel model = QuoteModel(quote: quote, author: author);
    locators
        .get<QuoteRepo>()
        .addMyQuote(model)
        .then((value) => emit(AddMyQuoteSuccessState()))
        .catchError((onError) {
      emit(AddMyQuoteErrorState(onError.toString()));
    });
  }

  editMyQuote(QuoteModel quote) {
    emit(EditMyQuoteLoadingState());
    locators.get<QuoteRepo>().updateMyQuote(quote).then((value) {
      emit(EditMyQuoteSuccessState());
    }).catchError((onError) {
      emit(EditMyQuoteErrorState(onError.toString()));
    });
  }
}
