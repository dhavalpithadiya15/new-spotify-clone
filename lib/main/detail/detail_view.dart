import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/main/detail/detail_cubit.dart';
import 'package:spotify_clone/main/detail/detail_state.dart';
import 'package:spotify_clone/modal/audio_modal.dart';
import 'package:spotify_clone/routes/routes.dart';

class DetailView extends StatelessWidget {
  final AudioModal data;

  const DetailView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                stops: [0.04, 0.5],
                colors: [Color(0xff7A3E3E), Colors.black],
              ),
            ),
            child: SafeArea(
              child: BlocBuilder<DetailCubit, DetailState>(
                builder: (context, state) {
                  return CustomScrollView(
                    controller: state.scrollController,
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        pinned: true,
                        expandedHeight: 199,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(height: 99, width: 100,decoration: BoxDecoration(image: DecorationImage(image: AssetImage(data.poster))),),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.player, arguments: {"poster": data.poster, "songList": data.audioList, "index": index});
                              },
                              title: Text(data.audioList[index].audioName, style: const TextStyle(color: Colors.white, fontSize: 18)),
                            );
                          },
                          childCount: data.audioList.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          color: Colors.transparent,
                          height: 700,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
/*
class CustomScrollingWidget extends StatefulWidget {
  const CustomScrollingWidget({Key? key}) : super(key: key);

  @override
  State createState() => _CustomScrollingWidgetState();
}

class _CustomScrollingWidgetState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('CustomScrollView'),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.tealAccent,
              alignment: Alignment.center,
              height: 200,
              child: const Text('This is Container'),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.amberAccent,
              alignment: Alignment.center,
              height: 200,
              child: const Text('This is Container'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 100.0,
                    child: Card(
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('Item $index'),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/
