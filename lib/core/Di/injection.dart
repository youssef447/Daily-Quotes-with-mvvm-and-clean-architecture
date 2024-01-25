import 'package:dailyquotes/model/repositories/apiReqRepo.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/model/services/DioReqService.dart';
import 'package:dailyquotes/model/services/Network/local/awesomeNotificationService.dart';
import 'package:dailyquotes/model/services/Network/local/sqfliteService.dart';
import 'package:get_it/get_it.dart';

final locators = GetIt.instance;

configurationDependencies() {
  locators.registerLazySingleton<AwesomeNotificationService>(
    () => AwesomeNotificationService(),
  );
  locators.registerLazySingleton<IReqRepo>(
    () => ApiReqRepo(
      remoteService: DioRemoteService(),
      localService: SqfliteService(),
    ),
  );
}
