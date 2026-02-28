class FundingProgram {
  final String id;
  final String name;
  final String amount;

  FundingProgram({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory FundingProgram.fromMap(String id, Map<String, dynamic> data) {
    return FundingProgram(
      id: id,
      name: data['name'],
      amount: data['amount'],
    );
  }
}