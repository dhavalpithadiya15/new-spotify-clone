import 'package:equatable/equatable.dart';

class AudioModal extends Equatable{
  final int id;
  final String albumName;
  final String poster;
  final List<SongsModal> audioList;

  const AudioModal({
    required this.id,
    required this.albumName,
    required this.poster,
    required this.audioList,
  });

  @override
  List<Object?> get props => [id,albumName,poster,audioList];

  AudioModal copyWith({
    int? id,
    String? albumName,
    String? poster,
    List<SongsModal>? audioList,
  }) {
    return AudioModal(
      id: id ?? this.id,
      albumName: albumName ?? this.albumName,
      poster: poster ?? this.poster,
      audioList: audioList ?? this.audioList,
    );
  }
}

class SongsModal{
  final String audioName;
  final String audio;

  const SongsModal({
    required this.audioName,
    required this.audio,
  });

  SongsModal copyWith({
    String? audioName,
    String? audio,
  }) {
    return SongsModal(
      audioName: audioName ?? this.audioName,
      audio: audio ?? this.audio,
    );
  }
}
