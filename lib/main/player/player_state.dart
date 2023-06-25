import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class MyPlayerState extends Equatable {
  final AudioPlayer audioPlayer;
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final  bool isRepeat;
  final int currentIndex;


  @override
  List<Object?> get props => [isPlaying, audioPlayer, duration, position, isRepeat,currentIndex];

  const MyPlayerState({
    required this.audioPlayer,
    this.isPlaying = false,
    required this.position,
    required this.duration,
    this.isRepeat=false,
    this.currentIndex=0,
  });

  MyPlayerState copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    Duration? duration,
    Duration? position,
    bool? isRepeat,
    int? currentIndex,
  }) {
    return MyPlayerState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isRepeat: isRepeat ?? this.isRepeat,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
