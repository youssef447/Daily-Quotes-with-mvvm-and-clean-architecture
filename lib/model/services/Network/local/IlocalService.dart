abstract class ILocalService {
  Future<void> initializeDB();
  //Future<bool> checkQuoteExist(int id);

  Future<void> addTodayQuote(Map<String, dynamic> query);
  Future<Map> getTodayQuote();
  Future<void> updateTodayQuote(Map<String, dynamic> query);

  Future<void> addFavQuote(Map<String, dynamic> query);
  Future<List<Map>> getFavQuotes();
  Future<void> removeFromFav(
    String quoteText, // we can remove by id instead.. better practice
  );
  Future<void> addMyQuoteService(Map<String, dynamic> query);
  Future<List<Map>> geMyQuotes();

  Future<void> updateMyQuoteService(Map<String, dynamic> query);
  Future<void> deleteMyQuoteService(int id);
}
