class Transactions {
  int? keyID;
  final String title;
  final double level;
  final DateTime date;
  final String ingredients;

  Transactions({
    this.keyID,
    required this.title,
    required this.level,
    required this.date,
    required this.ingredients,
  });
}