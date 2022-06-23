part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class DetailTvFetch extends DetailTvEvent {
  final int id;
  DetailTvFetch(this.id);

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
