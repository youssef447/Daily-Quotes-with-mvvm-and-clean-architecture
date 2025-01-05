import 'package:dailyquotes/core/helpers/api_result_helper.dart';

import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';
import 'update_today_usecase.dart';

class RemoveQuoteFromPopularUsecase {
  final QuoteRepo _quoteRepo;
  final UpdateTodayQuoteUseCase _updateTodayQuoteUsecase;

  RemoveQuoteFromPopularUsecase(this._quoteRepo, this._updateTodayQuoteUsecase);

  Future<ApiResult> removeQuoteFromPopular(QuoteEntity entity,
      [bool? isToday]) async {
    final res = await _quoteRepo.removeFromFav(entity.quote);
    if (res.isError) {
      return ApiResult.error(res.errorMessage!);
    }
    if (isToday ?? false) {
      final updateRes = await _updateTodayQuoteUsecase.updateTodayQuote(entity);
      if (updateRes.isError) {
        return ApiResult.error(updateRes.errorMessage!);
      }
      return ApiResult.success(data: updateRes.data);
    }
    return ApiResult.success();
  }
}
