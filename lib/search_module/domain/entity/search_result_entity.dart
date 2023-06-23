abstract class SearchResult {
  int id;
  String name;
  String about;
  String cover;
  String address;
  String type;

  SearchResult.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        about = json['about'],
        cover = json['cover'],
        address = json['address'],
        type = json['type'];
}