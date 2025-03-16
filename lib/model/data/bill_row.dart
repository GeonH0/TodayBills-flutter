class BillRow {
  final String billName; // BILL_NAME
  final String proposeDt; // PROPOSE_DT
  final String detailLink;
  final String committeeDt;
  final String lawProcDt;
  final String procDt;
  final String proposalReason;
  final String keyContent;

  BillRow({
    required this.billName,
    required this.proposeDt,
    required this.detailLink,
    required this.committeeDt,
    required this.lawProcDt,
    required this.procDt,
    required this.proposalReason,
    required this.keyContent,
  });

  factory BillRow.fromJson(Map<String, dynamic> json) {
    return BillRow(
      billName: (json['BILL_NAME'] as String?)?.orEmpty ?? '',
      proposeDt: (json['PROPOSE_DT'] as String?)?.orEmpty ?? '',
      detailLink: (json['DETAIL_LINK'] as String?)?.orEmpty ?? '',
      committeeDt: (json['CMT_PRESENT_DT'] as String?)?.orEmpty ?? '',
      lawProcDt: (json['LAW_PROC_DT'] as String?)?.orEmpty ?? '',
      procDt: (json['PROC_DT'] as String?)?.orEmpty ?? '',
      proposalReason: json['PROPOSAL_REASON']?.toString() ?? '',
      keyContent: json['KEY_CONTENT']?.toString() ?? '',
    );
  }
}

extension NullOrEmpty on String? {
  String get orEmpty {
    if (this == null || this == 'null') {
      return '';
    }
    return this!;
  }
}
