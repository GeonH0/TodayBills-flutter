class Bill {
  final String billId;
  final String billName;
  final String proposeDt;
  final String age;

  Bill({
    required this.billId,
    required this.billName,
    required this.proposeDt,
    required this.age,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      billId: json['BILL_ID']?.toString() ?? '',
      billName: json['BILL_NAME']?.toString() ?? '',
      proposeDt: json['PROPOSE_DT']?.toString() ?? '',
      age: json['AGE']?.toString() ?? '',
    );
  }
}
