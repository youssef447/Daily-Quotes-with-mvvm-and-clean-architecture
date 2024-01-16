abstract class ILocalService{
    Future<void> initializeDB();
  Future<List<Map>> getQuotes() ;

  Future<void>addQuote(Map<String, dynamic> query);

  Future<void>deleteQuote(int id);
   
}