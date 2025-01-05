import 'package:dailyquotes/domain/usecases/update_today_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../data/data_sources/quote_local_service.dart';
import '../../domain/usecases/add_quote_to_popular_usecase.dart';
import '../../domain/usecases/remove_quote_from_popular_usecase.dart';
import '../../domain/usecases/get_today_quote_usecase.dart';

import '../../data/data_sources/quote_remote_service.dart';
import '../../data/repositories/quote_repo.dart';
import '../services/notifications/awesome_notification_service.dart';

final locators = GetIt.instance;

configurationDependencies() {
  //Locale Notification
  locators.registerLazySingleton<AwesomeNotificationService>(
    () => AwesomeNotificationService(),
  );

//Repo

  locators.registerLazySingleton<QuoteRepo>(
    () => QuoteRepo(
      remoteService: QuoteRemoteService(),
      localService: QuoteLocalService(),
    ),
  );
  //use cases
  locators.registerLazySingleton<GetTodayQuoteUsecase>(
    () => GetTodayQuoteUsecase(locators()),
  );
  locators.registerLazySingleton<UpdateTodayQuoteUseCase>(
    () => UpdateTodayQuoteUseCase(locators()),
  );
  locators.registerLazySingleton<AddQuoteToPopularUsecase>(
    () => AddQuoteToPopularUsecase(locators(), locators()),
  );
  locators.registerLazySingleton<RemoveQuoteFromPopularUsecase>(
    () => RemoveQuoteFromPopularUsecase(locators(), locators()),
  );
}
