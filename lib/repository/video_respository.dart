import 'package:paymztest/model/video_model.dart';
import 'package:paymztest/services/api_provider.dart';

class VideoRespository {
  ApiProvider appApiProvider = ApiProvider();

  Future<List<VideoModel>> fetchVideos() => appApiProvider.fetchVideos();
}
