import 'package:dailyquotes/model/Entities/quote.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'randomStates.dart';

class RandomCubit extends Cubit<RandomStates> {
  RandomCubit() : super(RandomInitialState());
  static RandomCubit get(context) => BlocProvider.of(context);

  Quote? quote;


  getRandomQuote(){
    
  }
}
