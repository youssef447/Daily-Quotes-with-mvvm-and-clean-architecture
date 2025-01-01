import 'package:get_it/get_it.dart';

import '../../features/home_page/data/data_sources/quote_local_service.dart';
import '../services/notifications/awesome_notification_service.dart';

import '../../features/home_page/data/data_sources/quote_remote_service.dart';
import '../../features/home_page/data/repositories/quote_repo.dart';

final locators = GetIt.instance;

configurationDependencies() {
  //Locale Notification
  locators.registerLazySingleton<AwesomeNotificationService>(
      () => AwesomeNotificationService());

//Repo
  locators.registerLazySingleton<QuoteRepo>(() => QuoteRepo(
      remoteService: QuoteRemoteService(), localService: QuoteLocalService()));
}
