import '../../domain/entities/register_request.dart';

class RegistrationRequestModel extends RegistrationRequest {
  RegistrationRequestModel({
    required String ownerName,
    required String name,
    required String cover,
    required String address,
    required String website,
    required int regionId,
    required String about,
    required String email,
    required String phone,
  }) : super(
    ownerName: ownerName,
    name: name,
    address: address,
    website: website,
    coverURL: cover,
    regionId: regionId,
    about: about,
    email: email,
    phone: phone,
  );

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    return RegistrationRequestModel(
      ownerName: json['owner_name'],
      name: json['name'],
      regionId: json['region_id'],
      address: json['address'],
      cover: json['cover_url'],
      about: json['about'],
      email: json['email'],
      phone: json['phone'], website:json['website_url'],
    );
  }

  Map<String, dynamic> toJson(bool isCommunity) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[isCommunity?"requested_by":'owner_name'] = ownerName;
    data['name'] = name;
    data['region_id'] = regionId;
    data['about'] = about;
    data['address'] = address;
    data['cover_url'] = coverURL;
    data['email'] = email;
    data['phone'] = phone;
    data['website_url'] = website;
    return data;
  }
}