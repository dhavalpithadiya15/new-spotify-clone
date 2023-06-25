import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/main/detail/detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState(scrollController: ScrollController())){
    onScroll();
  }

  void onScroll() {
    var temp = state.scrollController;
    temp.addListener(() {
      print(temp.offset);
    });
  }
}
