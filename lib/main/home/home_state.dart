import 'dart:ui';

import 'package:equatable/equatable.dart';
import '../../modal/audio_modal.dart';
class HomeState extends Equatable {
  final List<AudioModal> listOfPoster;

  @override
  List<Object?> get props => [listOfPoster];

  const HomeState({
    this.listOfPoster = const [],
  });

  HomeState copyWith({
    List<AudioModal>? listOfPoster,
  }) {
    return HomeState(
      listOfPoster: listOfPoster ?? this.listOfPoster,
    );
  }
}
