

class VideoModel {
  var title;
  var description;
  var url;
  var updated;
  var thumbnail;
//  YoutubePlayerController controller;
  Future<void> initializeVideoPlayerFuture;

  static VideoModel fromJson(Map<String, dynamic> json) {
    var model = new VideoModel();
    model.title = json["title"];
    model.description = json["description"];
    model.url = json["url"];
    model.updated = json["updated"];
    model.thumbnail = json["thumbnail"];
    return model;
  }

//  void initVideoController() {
//    this.controller = YoutubePlayerController(
//      initialVideoId: YoutubePlayer.convertUrlToId(this.url),
//      flags: YoutubePlayerFlags(
//        autoPlay: true,
//        mute: true,
//      ),
//    );
//  }
}
