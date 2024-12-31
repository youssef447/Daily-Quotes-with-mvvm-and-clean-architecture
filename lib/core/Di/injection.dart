import 'package:get_it/get_it.dart';

import '../../data/data_sources/quote_local_service.dart';
import '../services/notifications/awesome_notification_service.dart';

import '../../data/data_sources/quote_remote_service.dart';
import '../../data/repositories/quote_repo.dart';

final locators = GetIt.instance;

configurationDependencies() {
  //Locale Notification
  locators.registerLazySingleton<AwesomeNotificationService>(
      () => AwesomeNotificationService());

//Repo
  locators.registerLazySingleton<QuoteRepoImp>(() => QuoteRepoImp(
      remoteService: QuoteRemoteService(), localService: QuoteLocalService()));
}
