import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DetailState extends Equatable{

  final ScrollController scrollController;
  final double imageContainerInitialSize;
  final double imageScale;

  @override
  List<Object?> get props =>[scrollController,imageContainerInitialSize,imageScale];

  const DetailState({
    required this.scrollController,
    this.imageContainerInitialSize=220,
    this.imageScale=1.0,
  });

  DetailState copyWith({
    ScrollController? scrollController,
    double? imageContainerInitialSize,
    double? imageScale,
  }) {
    return DetailState(
      scrollController: scrollController ?? this.scrollController,
      imageContainerInitialSize: imageContainerInitialSize ?? this.imageContainerInitialSize,
      imageScale: imageScale ?? this.imageScale,
    );
  }
}