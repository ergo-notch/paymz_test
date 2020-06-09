import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paymztest/model/video_model.dart';

class VideoCell extends StatefulWidget {
  final bool play;
  final VideoModel video;
  final Function(VideoModel) onTap;

  const VideoCell(
      {Key key,
      @required this.play,
      @required this.video,
      @required this.onTap})
      : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<VideoCell> {
  @override
  Widget build(BuildContext context) {
    return  Column(children: <Widget>[
          Container(
              color: Colors.white,
              alignment: Alignment.center,
              width: double.infinity,
              child: Material(
                  child: InkWell(
                onTap: () {
                  widget.onTap(widget.video);
                },
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 260,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.video.thumbnail),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Text(
              widget.video.title,
              style: TextStyle(color: Colors.black54, fontSize: 10.0),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Text(
              widget.video.description,
              style: TextStyle(color: Colors.black54, fontSize: 7.0),
            ),
          ),
        ]);
  }
}
