import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/view-model/addEditQuoteStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/Di/injection.dart';
import '../model/repositories/iRepo.dart';

class AddEditQuoteCubit extends Cubit<AddEditQuoteStates> {
  AddEditQuoteCubit() : super(AddEditQuoteInitialState());

  static AddEditQuoteCubit get(context) => BlocProvider.of(context);

  addMyQuote({required String quote, required String author}) {
    emit(AddMyQuoteLoadingState());
    QuoteModel model = QuoteModel(quote: quote, author: author);
    locators
        .get<IRepo>()
        .addMyQuote(model)
        .then((value) => emit(AddMyQuoteSuccessState()))
        .catchError((onError) {
      emit(AddMyQuoteErrorState(onError.toString()));
    });
  }

  editMyQuote(QuoteModel quote) {
    emit(EditMyQuoteLoadingState());
    locators.get<IRepo>().updateMyQuote(quote).then((value) {
      emit(EditMyQuoteSuccessState());
    }).catchError((onError) {
      emit(EditMyQuoteErrorState(onError.toString()));
    });
  }
}
