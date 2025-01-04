import 'package:dailyquotes/core/helpers/api_result_helper.dart';

import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';

class RemoveQuoteFromPopularUsecase {
  final QuoteRepo _quoteRepo;

  RemoveQuoteFromPopularUsecase(this._quoteRepo);

  Future<ApiResult> removeQuoteFromPopular(QuoteEntity entity,
      [bool? isToday]) async {
    entity.fav = false;
    final res = await _quoteRepo.removeFromFav(entity.quote);
    if (res.isSuccess) {
      if (isToday ?? false) {
        final updateRes = await _quoteRepo.updateTodayQuote(entity);
        if (updateRes.isSuccess) {
          return ApiResult.success(data: updateRes.data);
        } else {
          return ApiResult.error(updateRes.errorMessage!);
        }
      }
      return ApiResult.success();
    } else {
      return ApiResult.error(res.errorMessage!);
    }
  }
}
