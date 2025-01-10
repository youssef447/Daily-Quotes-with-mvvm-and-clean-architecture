import '../../core/helpers/api_result_helper.dart';
import '../../core/services/Network/local/cach_helper.dart';

import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';

///Handles Todays Quote Fetching .. Whether locally or remotely
class GetTodayQuoteUsecase {
  final QuoteRepo _quoteRepo;

  GetTodayQuoteUsecase(this._quoteRepo);

  Future<ApiResult<QuoteEntity>> getTodayQuote() async {
    final bool lastLocalFetchSuccess =
        await CacheHelper.getData(key: 'success') ?? false;
    if (lastLocalFetchSuccess) {
      final res = await _quoteRepo.getCachedTodayQuote();
      if (res.isError) {
        return ApiResult.error(res.errorMessage!);
      }
      return ApiResult.success(data: res.data!);
    }
    //will be first request if cache wasn't there, or will be requesting again, so i don't get same old quote from cache everytime beacause of a failed workmanger process
    return _requestTodayQuote();
  }

  Future<ApiResult<QuoteEntity>> _requestTodayQuote() async {
    final res = await _quoteRepo.reqTodayQuote();
    if (res.isError) {
      return ApiResult.error(res.errorMessage!);
    }

    //cache quote
    final cacheRes = await _quoteRepo.cacheTodayQuote(res.data!);
    if (cacheRes.isError) {
      return ApiResult.error(cacheRes.errorMessage!);
    }
    await CacheHelper.saveData(key: 'success', value: true);
    return ApiResult.success(data: cacheRes.data!);
  }
}
