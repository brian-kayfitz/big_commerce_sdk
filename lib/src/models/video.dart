class Video {
  /// The ID of the video on a host site.
  /// Example - z3fRu9pkuXE
  final String videoId;
  final VideoType type;
  final int? id;

  Video({
    this.id,
    required this.videoId,
    this.type = VideoType.youtube,
  });

  Video.fromJson(Map json)
      : id = json['id'],
        videoId = json['video_id'],
        type = VideoType.youtube;

  Map toJson() => {
        'video_id': videoId,
        'type': type.name,
      };
}

enum VideoType {
  youtube,
}
