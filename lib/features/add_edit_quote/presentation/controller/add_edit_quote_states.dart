abstract class AddEditQuoteStates {}

class AddEditQuoteInitialState extends AddEditQuoteStates {}



class AddMyQuoteLoadingState extends AddEditQuoteStates {}

class AddMyQuoteSuccessState extends AddEditQuoteStates {}

class AddMyQuoteErrorState extends AddEditQuoteStates {
  final String err;
  AddMyQuoteErrorState(this.err);
}

class EditMyQuoteLoadingState extends AddEditQuoteStates {}

class EditMyQuoteSuccessState extends AddEditQuoteStates {}

class EditMyQuoteErrorState extends AddEditQuoteStates {
  final String err;
  EditMyQuoteErrorState(this.err);
}
