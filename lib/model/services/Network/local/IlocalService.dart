abstract class ILocalService {
  Future<void> initializeDB();
  //Future<bool> checkQuoteExist(int id);

  Future<void> addTodayQuote(Map<String, dynamic> query);
  Future<Map> getTodayQuote();
  Future<void> updateTodayQuote(Map<String, dynamic> query);

  

  Future<void> addFavQuote(Map<String, dynamic> query);
  Future<List<Map>> getFavQuotes();
  Future<void> removeFromFav(String quoteText);
}
