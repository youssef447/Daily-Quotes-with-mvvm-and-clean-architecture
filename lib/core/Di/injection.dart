
import 'package:get_it/get_it.dart';

import '../../model/repositories/iRepo.dart';
import '../../model/repositories/quoteRepo.dart';
import '../../model/services/dioRemoteService.dart';
import '../../model/services/Network/local/sqfliteService.dart';
import '../../model/services/awesomeNotificationService.dart';

final locators = GetIt.instance;

configurationDependencies() {
  locators.registerLazySingleton<AwesomeNotificationService>(
    () => AwesomeNotificationService(),
  );
  locators.registerLazySingleton<IRepo>(
    () => QuoteRepo(
      remoteService: DioRemoteService(),
      localService: SqfliteService(),
    ),
  );
}
