class LimitParametersModel {
  final int regionId;
  final int limit;
  final int offset;
  final int? categoryId;

  LimitParametersModel( {
    required this.regionId,
    this.limit = 0,
    this.offset = 0,this.categoryId,
  });

  factory LimitParametersModel.fromJson(Map<String, dynamic> json) {
    return LimitParametersModel(
      regionId: json['regionId'],
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      categoryId: json['categoryId']??1
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regionId': regionId,
      'limit': limit,
      'offset': offset,
      'categoryId': categoryId,
    };
  }
}