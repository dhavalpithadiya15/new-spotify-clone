import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DetailState extends Equatable{

  final ScrollController scrollController;



  @override
  // TODO: implement props
  List<Object?> get props =>[scrollController];

  const DetailState({
    required this.scrollController,
  });

  DetailState copyWith({
    ScrollController? scrollController,
  }) {
    return DetailState(
      scrollController: scrollController ?? this.scrollController,
    );
  }
}