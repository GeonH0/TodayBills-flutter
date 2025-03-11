class Bill {
  final String billId;
  final String billName;
  final String proposeDt;

  Bill({
    required this.billId,
    required this.billName,
    required this.proposeDt,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      billId: json['BILL_ID']?.toString() ?? '',
      billName: json['BILL_NAME']?.toString() ?? '',
      proposeDt: json['PROPOSE_DT']?.toString() ?? '',
    );
  }
}
