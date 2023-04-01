class ItemListingException implements Exception{
  final String message;

  ItemListingException({this.message = 'Unknown error occurred. '});
}