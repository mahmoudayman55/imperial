import 'package:imperial/community_module/domain/entity/event_cover.dart';

class EventCoverModel extends EventCover{
  EventCoverModel({super.id=-1, required super.coverUrl});
  factory EventCoverModel.fromJson(Map<String, dynamic> json) {
    return EventCoverModel(
      coverUrl: json['cover_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cover_url': super.coverUrl,
    };
  }
}