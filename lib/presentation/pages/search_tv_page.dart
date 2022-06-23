import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/common/state_enum.dart';
import 'package:tv_series_imdb/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_imdb/presentation/widgets/tv_card_2.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  String _query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      IconlyLight.arrow_left_2,
                      size: 14,
                      color: kExoticBlack,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (query) {
                        context.read<SearchTvBloc>().add(onQueryChange(query));
                      },
                      onChanged: (query) {
                        _query = query;
                        context.read<SearchTvBloc>().add(onQueryChange(query));
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write title or name content',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                       context.read<SearchTvBloc>().add(onQueryChange(_query));
                    },
                    icon: Icon(
                      IconlyLight.search,
                      size: 20,
                      color: kExoticBlack,
                    ),
                  ),
                ],
              ),
              Divider(color: kPrimereBlack, height: 8, thickness: 1),
              
              BlocBuilder<SearchTvBloc, SearchTvState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is SearchHasData) {
                    final result = state.result;
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final tv = result[index];
                          return TvCardV2(tv);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else if (state is SearchError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
