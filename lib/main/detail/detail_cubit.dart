import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/main/detail/detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState(scrollController: ScrollController())) {
    onScroll();
  }

  void onScroll() {
    var tempScrollController = state.scrollController;
    double tempImageContainerSize = state.imageContainerInitialSize;
    tempScrollController.addListener(() {
      double size = tempImageContainerSize - tempScrollController.offset;
      double scale= 1.0-(tempScrollController.offset)/tempImageContainerSize;
      print("Scale ==>$scale");
      print("Size ==>$size");
      print("ScrollControllerOffSet ==>${tempScrollController.offset}");
      emit(state.copyWith(imageContainerInitialSize: size,imageScale: scale));
    });
  }
}
