import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv_series_imdb/presentation/widgets/tv_card_2.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top_rated_tv';

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TopRatedTvBloc>().add(TopRatedTvFetch()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              IconlyLight.arrow_left,
              color: Colors.white,
            )),
        title: Text(
          'Top Rated',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kExoticBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TopRatedTvBloc,TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final result = state.result[index];
                  return TvCardV2(result);
                },
                itemCount: state.result.length,
              );
            } else if(state is TopRatedTvError){
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }else{
              return Center(
                child: Text('Failure'),
              );
            }
          },
        ),
      ),
    );
  }
}
