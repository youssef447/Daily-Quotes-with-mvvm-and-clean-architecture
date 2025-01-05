import '../../core/helpers/api_result_helper.dart';
import '../../data/repositories/quote_repo.dart';
import '../entity/quote_entity.dart';

class UpdateTodayQuoteUseCase {
  final QuoteRepo _quoteRepo;

  UpdateTodayQuoteUseCase(this._quoteRepo);

  Future<ApiResult> updateTodayQuote(QuoteEntity entity) async {
    return await _quoteRepo.updateTodayQuote(entity);
  }
}
