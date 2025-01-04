import '../../core/helpers/api_result_helper.dart';
import '../../data/models/quote_model.dart';
import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';

class GetTodayQuoteUsecase {
  final QuoteRepo _quoteRepo;

  GetTodayQuoteUsecase(this._quoteRepo);

  Future<ApiResult<QuoteEntity>> getTodayQuote() async {
    final res = await _quoteRepo.getCachedTodayQuote();
    if (res.isSuccess) {
      return ApiResult.success(data: res.data!);
    } else {
      return ApiResult.error(res.errorMessage!);
    }
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
