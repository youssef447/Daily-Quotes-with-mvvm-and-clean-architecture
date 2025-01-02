import '../../core/helpers/api_result_helper.dart';
import '../../core/services/Network/local/cach_helper.dart';
import '../../data/models/quote_model.dart';
import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';

class TodayQuoteUsecase {
  final QuoteRepo _quoteRepo;

  TodayQuoteUsecase(this._quoteRepo);

  Future<ApiResult<QuoteEntity>> getTodayQuote() async {
    //Not Cached Yet
    if (!CacheHelper.containsKey('date')) {
      return _requestTodayQuote();
    }
    // Was Cached Before
    DateTime cachedDate = DateTime.parse(CacheHelper.getData(key: 'date'));

// Check if the cached date is today's date or if its 1 day diff but still was after 8 :00 am from previous day
    if ((DateTime.now().difference(cachedDate).inDays == 0 &&
            DateTime.now().hour < 8) ||
        (DateTime.now().difference(cachedDate).inDays == 1 &&
            cachedDate.hour >= 8)) {
      // If it's before 8 AM today, use the cached quote

      final res = await _quoteRepo.getCachedTodayQuote();
      if (res.isSuccess) {
        return ApiResult.success(data: res.data!);
      } else {
        return ApiResult.error(res.errorMessage!);
      }
    }

    //same day but now is after 8 am (cache is range 12 am To 7:59 am as its the same day)
    //or not same day or only 1 day and cach was before 8 am (example cache was range 12 am to 7 am previous day)
    return _requestTodayQuote();
  }

  Future<ApiResult<QuoteEntity>> _requestTodayQuote() async {
    final res = await _quoteRepo.reqTodayQuote();
    if (res.isSuccess) {
      final quoteModel = QuoteModel.fromEntity(res.data!);
      //cach quote
      await _quoteRepo.cacheTodayQuote(quoteModel);
      return ApiResult.success(data: res.data!);
    } else {
      return ApiResult.error(res.errorMessage!);
    }
  }
}
