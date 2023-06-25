import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotify_clone/main/home/home_state.dart';
import 'package:spotify_clone/modal/audio_modal.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    addImages();
  }

  void addImages() {
    print("clksnc");
    List<AudioModal> tempList = state.listOfPoster;
    tempList = [
      const AudioModal(
        id: 1,
        albumName: "Jab we met",
        poster: "assets/images/posters/poster1.jpg",
        audioList: [
          SongsModal(
            audioName: "Aao Milo Chale",
            audio: "assets/audio/aao-milo-chale.mp3",
          ),
          SongsModal(
            audioName: "Yeh Ishq Hai",
            audio: "assets/audio/yeh-Ishq-hai.mp3",
          ),
          SongsModal(
            audioName: "Nagada Nagada",
            audio: "assets/audio/nagada-nagada.mp3",
          ),
          SongsModal(
            audioName: "Mauja Hi Mauja",
            audio: "assets/audio/mauja-hi-mauja.mp3",
          ),
        ],
      ),
      const AudioModal(
        id: 2,
        albumName: "Phantom",
        poster: "assets/images/posters/poster2.jpg",
        audioList: [
          SongsModal(
            audioName: "Saware",
            audio: "assets/audio/saware.mp3",
          ),
          SongsModal(
            audioName: "Afjan Jalebi",
            audio: "assets/audio/afghan-Jalebi.mp3",
          ),
        ],
      ),
      const AudioModal(
        id: 3,
        albumName: "Raanjhanaa",
        poster: "assets/images/posters/poster3.jpg",
        audioList: [
          SongsModal(audioName: "Raanjhanaa", audio: "assets/audio/raanjhanaa-raanjhanaa.mp3"),
          SongsModal(audioName: "Tum Tak", audio: "assets/audio/tum-tak.mp3"),
        ],
      )
    ];
    emit(state.copyWith(listOfPoster: tempList));
    print(state.listOfPoster);
  }
}
