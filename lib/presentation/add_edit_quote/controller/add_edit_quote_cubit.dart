import 'package:dailyquotes/presentation/add_edit_quote/controller/add_edit_quote_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';

import '../../../domain/entity/quote_entity.dart';

class AddEditQuoteCubit extends Cubit<AddEditQuoteStates> {
  AddEditQuoteCubit() : super(AddEditQuoteInitialState());

  static AddEditQuoteCubit get(context) => BlocProvider.of(context);

  late final TextEditingController quoteController;

  late final TextEditingController authorController;
  setQuoteFields([QuoteEntity? quote]) {
    quoteController = TextEditingController(text: quote?.quote);
    authorController = TextEditingController(text: quote?.author);
  }

  Future<void> addMyQuote() async {
    emit(AddMyQuoteLoadingState());
    QuoteEntity model = QuoteEntity(
        quote: quoteController.text.trim(),
        author: authorController.text.trim());
    final res = await locators.get<QuoteRepo>().addMyQuote(model);
    if (res.isSuccess) {
      emit(AddMyQuotesPageuccessState());
    } else {
      emit(AddMyQuoteErrorState(res.errorMessage!));
    }
  }

  Future<void> editMyQuote(QuoteEntity quote) async {
    quote.author = authorController.text.trim();
    quote.quote = quoteController.text.trim();
    emit(EditMyQuoteLoadingState());
    final res = await locators.get<QuoteRepo>().updateMyQuote(quote);

    if (res.isSuccess) {
      emit(EditMyQuotesPageuccessState());
    } else {
      emit(EditMyQuoteErrorState(res.errorMessage!));
    }
  }
}
