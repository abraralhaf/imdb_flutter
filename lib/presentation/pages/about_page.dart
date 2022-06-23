import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_imdb/common/constants.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBixUsScrikked) => [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Text('About', style: kHeading6),
          )
        ],
        body: Center(
            child: Text(
          'check on my github @abraralhaf',
        )),
      )),
    );
  }
}
