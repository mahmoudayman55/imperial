class RegistrationRequest {
  String ownerName;
  String name;
  String address;
  String coverURL;

  int regionId;
  String about;
  String website;
  String email;
  String phone;

  RegistrationRequest({
    required this.ownerName,
    required this.name,
    required this.address,
    required this.website,
    required this.coverURL,
    required this.regionId,
    required this.about,
    required this.email,
    required this.phone,
  });
}