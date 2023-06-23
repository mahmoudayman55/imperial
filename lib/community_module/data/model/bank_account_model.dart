class BankAccount {
  int id;
  String accountName;
  String accountNumber;
  String sortCode;

  String bankName;
  String bankAddress;
  int communityId;

  BankAccount({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.sortCode,
    required this.bankName,
    required this.bankAddress,
    required this.communityId,

  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      sortCode: json['sort_code'],

      bankName: json['bank_name'],
      bankAddress: json['bank_address'],
      communityId: json['community_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'account_name': accountName,
    'account_number': accountNumber,
    'sort_code': sortCode,

    'bank_name': bankName,
    'bank_address': bankAddress,
    'community_id': communityId,

  };
}