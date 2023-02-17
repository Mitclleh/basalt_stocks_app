part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class CheckInternetConnectivityStatus extends ConnectivityEvent {
  final ConnectivityResult? updatedConnectivityResult;

  const CheckInternetConnectivityStatus({this.updatedConnectivityResult});
}
