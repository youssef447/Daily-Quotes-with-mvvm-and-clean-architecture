import 'package:dailyquotes/model/repositories/apiReqRepo.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/model/services/DioReqService.dart';
import 'package:dailyquotes/model/services/Network/local/sqfliteService.dart';
import 'package:get_it/get_it.dart';

final locators = GetIt.instance;

configurationDependencies() {
  locators.registerLazySingleton<IReqRepo>(
    () => ApiReqRepo(
     remoteService: DioReqService(),
     localService:SqfliteService(),
    ),
  );


}
