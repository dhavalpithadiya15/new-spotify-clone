import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/main/player/player_state.dart';
import 'package:spotify_clone/modal/audio_modal.dart';

class MyPlayerCubit extends Cubit<MyPlayerState> {
  MyPlayerCubit() : super(MyPlayerState(audioPlayer: AudioPlayer(), position: const Duration(), duration: const Duration()));

  Future<void> addAudio(String audioName, int passedIndex) async {
    print("fbjdkbvj===${audioName}");
    var temp = state.audioPlayer;
    temp.setAsset(audioName);
    emit(state.copyWith(audioPlayer: temp, currentIndex: passedIndex));
    print(state.currentIndex);
  }

  Future<void> playAndPauseAudio() async {
    var tempIsPlaying = state.isPlaying;
    if (!tempIsPlaying) {
      state.audioPlayer.play();
      setupAudioPlayerListener();
      emit(state.copyWith(isPlaying: !tempIsPlaying));
    } else {
      state.audioPlayer.pause();
      setupAudioPlayerListener();
      emit(state.copyWith(isPlaying: !tempIsPlaying));
    }
    print(state.isPlaying);
  }

  void setupAudioPlayerListener() {
    state.audioPlayer.durationStream.listen((event) {
      emit(state.copyWith(duration: event));
      print("Duration ==> ${state.duration.inSeconds}");
    });
    state.audioPlayer.positionStream.listen((event) {
      emit(state.copyWith(position: event));
      print("Postion ==> ${state.position.inSeconds}");
      if (state.position.inSeconds >= state.duration.inSeconds) {
        if (state.isRepeat) {
          state.audioPlayer.setLoopMode(LoopMode.one);
          print("Repeat ==> ${state.isRepeat}");
        } else {
          state.audioPlayer.stop();
          print("Repeat ==> ${state.isRepeat}");
        }
      }
    });
  }

  void seekAudio(int value) {
    state.audioPlayer.seek(Duration(seconds: value));
  }

  void setRepeat() {
    var temp = state.isRepeat;
    if (!temp) {
      emit(state.copyWith(isRepeat: !temp));
      print(state.isRepeat);
    } else {
      emit(state.copyWith(isRepeat: !temp));
    }
  }

  Future<bool> stopAudio(BuildContext context) async {
    if (state.isPlaying) {
      await state.audioPlayer.stop().then((value) {
        Navigator.pop(context);
      });
      emit(state.copyWith(isPlaying: false));
    } else {
      Navigator.pop(context);
    }
    return true;
  }

  void pageChange(int value, String songList) {
    state.audioPlayer.setAsset(songList);
    emit(state.copyWith(currentIndex: value));
    print("current index==>${state.currentIndex}");
  }

/*  void forwardTap(int passedIndex, List<SongsModal> songList) {
    passedIndex=passedIndex+1;
    print(passedIndex);
  }*/
}
