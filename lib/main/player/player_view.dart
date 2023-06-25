import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/main/player/player.cubit.dart';
import 'package:spotify_clone/main/player/player_state.dart';
import 'package:spotify_clone/modal/audio_modal.dart';

class PlayerView extends StatelessWidget {
  final String poster;
  final List<SongsModal> songList;
  final int passedIndex;

  const PlayerView({Key? key, required this.poster, required this.songList, required this.passedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("PASSED INDEX ==>${passedIndex}");

    return BlocProvider(
      create: (context) => MyPlayerCubit()..addAudio(songList[passedIndex].audio, passedIndex),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return BlocProvider.of<MyPlayerCubit>(context).stopAudio(context);
          },
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade900, Colors.black],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Favorite song", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                          Icon(
                            CupertinoIcons.ellipsis_vertical,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.38,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 20), blurRadius: 32, spreadRadius: 16),
                          ],
                        ),
                        child: PageView.builder(
                          controller: PageController(initialPage: context.read<MyPlayerCubit>().state.currentIndex),
                          onPageChanged: (value) {
                            BlocProvider.of<MyPlayerCubit>(context).pageChange(value, songList[value].audio);
                          },
                          itemCount: songList.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(poster),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<MyPlayerCubit, MyPlayerState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  songList[state.currentIndex].audioName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Slider(
                                inactiveColor: Colors.blue.shade600,
                                activeColor: Colors.blue.shade800,
                                value: state.position.inSeconds.toDouble(),
                                max: state.duration.inSeconds.toDouble(),
                                min: 0.0,
                                onChanged: (value) {
                                  BlocProvider.of<MyPlayerCubit>(context).seekAudio(value.toInt());
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.position.toString().split(".")[0],
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                  Text(
                                    state.duration.toString().split(".")[0],
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.shuffle,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<MyPlayerCubit>(context).playAndPauseAudio();
                                    },
                                    icon: Icon(
                                      state.isPlaying ? Icons.pause : Icons.play_arrow,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      /*BlocProvider.of<MyPlayerCubit>(context).forwardTap(state.currentIndex,songList);*/
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<MyPlayerCubit>(context).setRepeat();
                                    },
                                    icon: Icon(
                                      Icons.loop,
                                      size: 30,
                                      color: state.isRepeat ? Colors.blue : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
