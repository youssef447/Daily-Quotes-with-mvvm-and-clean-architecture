import 'package:dailyquotes/core/helpers/api_result_helper.dart';
import 'package:dailyquotes/domain/usecases/get_today_quote_usecase.dart';

import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';
import 'update_today_usecase.dart';

class RemoveQuoteFromPopularUsecase {
  final QuoteRepo _quoteRepo;
  final UpdateTodayQuoteUseCase _updateTodayQuoteUsecase;
  final GetTodayQuoteUsecase _getTodayQuoteUsecase;

  RemoveQuoteFromPopularUsecase(this._quoteRepo, this._updateTodayQuoteUsecase,
      this._getTodayQuoteUsecase);

  Future<ApiResult> removeQuoteFromPopular(
    QuoteEntity entity,
  ) async {
    final res = await _quoteRepo.removeFromFav(entity.quote);
    if (res.isError) {
      return ApiResult.error(res.errorMessage!);
    }
    final res2 = await _getTodayQuoteUsecase.getTodayQuote();
    if (res2.isError) {
      return ApiResult.error(res2.errorMessage!);
    }
    if (res2.data!.quote == entity.quote) {
      final updateRes =
          await _updateTodayQuoteUsecase.updateTodayQuote(res2.data!);
      if (updateRes.isError) {
        return ApiResult.error(updateRes.errorMessage!);
      }
      return ApiResult.success(data: updateRes.data);
    }
    return ApiResult.success();
  }
}
