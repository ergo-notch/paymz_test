import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymztest/model/video_model.dart';
import 'package:paymztest/repository/video_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'event.dart';

part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VideoRespository repository;

  HomeBloc({@required this.repository});

  @override
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHomeEvent) {
      yield LoadingState();
      try {
        List<VideoModel> videos = await repository.fetchVideos();
        yield LoadedState(items: videos);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }
  }
}
