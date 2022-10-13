import 'package:example/controls.dart';
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

// class CallArgs {
//   final String callId;
//   CallArgs({required this.callId});
// }

class StageView extends StatefulWidget {
  final CallParticipantController controller;
  final TrackController trackController;
  static String routeName = "/stageView";

  const StageView({
    Key? key,
    required this.controller,
    required this.trackController,
  }) : super(key: key);

  @override
  State<StageView> createState() => _StageViewState();
}

class _StageViewState extends State<StageView> {
  @override
  Widget build(BuildContext context) {
    //TODO: busy widget

    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: BottomControls(onRefresh: () {
            //make this cleaner
            setState(() {});
          })),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: allParticipants.length, //
              itemBuilder: (BuildContext ctx, int index) {
                return Stack(children: [
                  // allParticipants[index].videoTracks.isNotEmpty &&
                  //         allParticipants[index].videoTracks[0].track != null &&
                  allParticipants[index].hasVideo
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: StreamVideoTrackRenderer(
                              controller: widget.trackController,
                              track: allParticipants[index].track!
                              ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                  Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Row(
                      children: [
                        if (!allParticipants[index].hasAudio)
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.mic_off,
                              color: Colors.red,
                              size: 12,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            allParticipants[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
                // );
              })),
      // ),
    ));
  }

  List<CallParticipant> get allParticipants =>
      widget.controller.participants;
}
