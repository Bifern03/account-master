class Transactions {
  int? keyID;
  final String title;
  final double amount;
  final DateTime date;
  final String ingredients;

  Transactions({
    this.keyID,
    required this.title,
    required this.amount,
    required this.date,
    required this.ingredients,
  });
}