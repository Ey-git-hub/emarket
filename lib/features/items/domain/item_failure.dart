class ItemFailure implements Exception {
  const ItemFailure(this.message);

  final String message;

  @override
  String toString() => message;
}