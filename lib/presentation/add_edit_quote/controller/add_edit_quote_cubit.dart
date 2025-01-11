import 'package:dailyquotes/core/di/injection.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';
import 'package:dailyquotes/presentation/add_edit_quote/controller/add_edit_quote_states.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dailyquotes/data/repositories/quote_repo.dart';

class AddEditQuoteCubit extends Cubit<AddEditQuoteStates> {
  AddEditQuoteCubit() : super(AddEditQuoteInitialState());

  static AddEditQuoteCubit get(context) => BlocProvider.of(context);

  late final TextEditingController quoteController;

  late final TextEditingController authorController;
  setQuoteFields([QuoteEntity? quote]) {
    quoteController = TextEditingController(text: quote?.quote);
    authorController = TextEditingController(text: quote?.author);
  }

  Future<void> addMyQuote(BuildContext context) async {
    emit(AddMyQuoteLoadingState());
    QuoteEntity model = QuoteEntity(
        quote: quoteController.text.trim(),
        author: authorController.text.trim());
    final res = await locators.get<QuoteRepo>().addMyQuote(model);
    if (res.isSuccess) {
      emit(AddMyQuotesPageuccessState());
      if (context.mounted) {
        {
          context.read<MyQuotesCubit>().getMyQuotes();
          AwesomeDialogUtil.sucess(
            context: context,
            body: 'Quote Added Successfully',
            title: 'Done',
            onDismissCallback: (_) => Navigator.of(context).pop(),
          );
        }
      } else {
        emit(AddMyQuoteErrorState(res.errorMessage!));
        if (context.mounted) {
          AwesomeDialogUtil.error(
            context: context,
            body: 'Error Adding Your Quote, please try again',
            title: 'Failed',
            onDismissCallback: (_) => Navigator.of(context).pop(),
          );
        }
      }
    }
  }

  Future<void> editMyQuote(QuoteEntity quote,
      {required BuildContext context}) async {
    quote.author = authorController.text.trim();
    quote.quote = quoteController.text.trim();
    emit(EditMyQuoteLoadingState());
    final res = await locators.get<QuoteRepo>().updateMyQuote(quote);

    if (res.isSuccess) {
      emit(EditMyQuotesPageuccessState());
      if (context.mounted) {
        context.read<MyQuotesCubit>().getMyQuotes();
        AwesomeDialogUtil.sucess(
          context: context,
          body: 'Quote Upadated!',
          title: 'Done',
          onDismissCallback: (_) => Navigator.of(context).pop(),
        );
      }
    } else {
      emit(EditMyQuoteErrorState(res.errorMessage!));
      if (context.mounted) {
        AwesomeDialogUtil.error(
          context: context,
          body: 'Error Upadting Your Quote, please try again',
          title: 'Failed',
          onDismissCallback: (_) => Navigator.of(context).pop(),
        );
      }
    }
  }
}
