import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paymztest/bloc/home/home_bloc.dart';
import 'package:paymztest/model/video_model.dart';
import 'package:paymztest/ui/home/widgets/video_cell.dart';
import 'package:paymztest/ui/home/widgets/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(FetchHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      // ignore: missing_return
      listener: (context, state) {
        if (state is ErrorState) {
          return Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is InitialState || state is LoadingState) {
          return buildLoading();
        } else if (state is LoadedState) {
          return buildVideoList(state.items);
        } else {
          return buildLoading();
        }
      }),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildVideoList(List<VideoModel> videos) {
    return Scaffold(
        body: AnimationLimiter(
            child: SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        addAutomaticKeepAlives: true,
                        itemCount: videos.isEmpty ? 0 : videos.length,
                        itemBuilder: (BuildContext context, int index) =>
                            AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                    verticalOffset: 150.0,
                                    child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: FadeInAnimation(
                                            child: VideoCell(
                                          play: true,
                                          video: videos.elementAt(index),
                                          onTap: (video) =>
                                              Navigator.of(context).push(
                                                  new CustomPageRoute(
                                                      videos.elementAt(index))),
                                        ))))))
                  ],
                ))));
  }
}

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute(VideoModel video)
      : super(
            builder: (context) => new VideoPlayer(
                  url: video.url,
                ));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
