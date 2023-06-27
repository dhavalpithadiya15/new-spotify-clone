import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/main/detail/detail_cubit.dart';
import 'package:spotify_clone/main/detail/detail_state.dart';
import 'package:spotify_clone/modal/audio_modal.dart';
import 'package:spotify_clone/routes/routes.dart';
import 'dart:math' as math;

class DetailView extends StatelessWidget {
  final AudioModal data;

  const DetailView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxAppBarHeight = MediaQuery.of(context).size.height * 0.45;
    double minAppBarHeight = MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.1;

    return BlocProvider(
      create: (context) => DetailCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff7A3E3E),
                    Colors.black,
                  ],
                  stops: [0, 0.7],
                  ),
            ),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverCustomeAppBar(
                      maxAppBarHeight: maxAppBarHeight,
                      minAppBarHeight: maxAppBarHeight,
                      image: data.poster,
                      tittle: data.albumName,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.player, arguments: {"poster": data.poster, "songList": data.audioList, "index": index});
                                },
                                leading: Text("${index + 1}", style: TextStyle(color: Colors.white)),
                                title: Text(data.audioList[index].audioName, style: TextStyle(color: Colors.white)),
                              )),
                          childCount: data.audioList.length),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 800
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class AlbumInfo extends StatelessWidget {
  const AlbumInfo({
    Key? key,
    required this.infoBoxHeight,
  }) : super(key: key);

  final double infoBoxHeight;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            Colors.transparent,
            Colors.black87,
          ], stops: [
            0.00022,
            1.0,
          ]),
        ),
        child: SizedBox(
          height: infoBoxHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "=",
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    Text(
                      "Ed Sheeran",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox.shrink()
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Album . 2021",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliverCustomeAppBar extends StatelessWidget {
  const SliverCustomeAppBar({
    Key? key,
    required this.maxAppBarHeight,
    required this.minAppBarHeight,
    required this.image,
    required this.tittle,
  }) : super(key: key);

  final double maxAppBarHeight;
  final double minAppBarHeight;
  final String image;
  final String tittle;

  @override
  Widget build(BuildContext context) {
    final extraTopPadding = MediaQuery.of(context).size.height * 0.028;
    final padding = EdgeInsets.only(top: 30 + extraTopPadding, right: 10, left: 10, bottom: 15);

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        maxHeight: maxAppBarHeight,
        minHeight: minAppBarHeight,
        builder: (context, shrinkOffset) {
          final double shrinkToMaxAppBarHeightRatio = shrinkOffset / maxAppBarHeight;
          const double animatAlbumImageFromPoint = 0.4;
          final animateAlbumImage = shrinkToMaxAppBarHeightRatio >= animatAlbumImageFromPoint;
          final animateOpacityToZero = shrinkToMaxAppBarHeightRatio > 0.6;
          final albumPositionFromTop = animateAlbumImage ? (animatAlbumImageFromPoint - shrinkToMaxAppBarHeightRatio) * maxAppBarHeight : null;
          final albumImageSize = MediaQuery.of(context).size.height * 0.3 - shrinkOffset / 2;
          final showFixedAppBar = shrinkToMaxAppBarHeightRatio > 0.7;
          final double titleOpacity = showFixedAppBar ? 1 - (maxAppBarHeight - shrinkOffset) / minAppBarHeight : 0;
          print(titleOpacity);

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: albumPositionFromTop,
                child: AlbumImage(
                  padding: padding,
                  animateOpacityToZero: animateOpacityToZero,
                  animateAlbumImage: animateAlbumImage,
                  shrinkToMaxAppBarHeightRatio: shrinkToMaxAppBarHeightRatio,
                  albumImageSize: albumImageSize,
                  image: image,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  gradient: showFixedAppBar
                      ? LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [const Color(0xff7A3E3E), Colors.black.withOpacity(0.3)], stops: [0, 0.5])
                      : null,
                ),
                child: Padding(
                  padding: padding,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FixedAppBar(
                      titleOpacity: titleOpacity,
                      tittle: tittle,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

typedef _SliverAppBarDelegateBuilder = Widget Function(
  BuildContext context,
  double shrinkOffset,
);

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  });

  final double minHeight;
  final double maxHeight;
  final _SliverAppBarDelegateBuilder builder;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: builder(context, shrinkOffset),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || builder != oldDelegate.builder;
  }
}

class AlbumImage extends StatelessWidget {
  const AlbumImage({
    Key? key,
    required this.padding,
    required this.animateOpacityToZero,
    required this.animateAlbumImage,
    required this.shrinkToMaxAppBarHeightRatio,
    required this.albumImageSize,
    required this.image,
  }) : super(key: key);

  final EdgeInsets padding;
  final bool animateOpacityToZero;
  final bool animateAlbumImage;
  final double shrinkToMaxAppBarHeightRatio;
  final double albumImageSize;

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: animateOpacityToZero
            ? 0
            : animateAlbumImage
                ? 1 - shrinkToMaxAppBarHeightRatio
                : 1,
        child: Container(
          height: albumImageSize,
          width: albumImageSize,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black87,
                spreadRadius: 1,
                blurRadius: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FixedAppBar extends StatelessWidget {
  const FixedAppBar({
    Key? key,
    required this.titleOpacity,
    required this.tittle,
  }) : super(key: key);

  final double titleOpacity;
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 30),
        AnimatedOpacity(
          opacity: titleOpacity.clamp(0, 1),
          duration: const Duration(milliseconds: 100),
          child: Text(
            tittle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
