part of 'stocks_summary_bloc.dart';

@immutable
abstract class StocksSummaryEvent {}

class LoadStocks extends StocksSummaryEvent {
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  LoadStocks({this.startDateTime, this.endDateTime});
}

class ChangeDateRange extends StocksSummaryEvent {
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  ChangeDateRange({this.startDateTime, this.endDateTime});
}

class FilterStocks extends StocksSummaryEvent {
  final String text;
  FilterStocks({required this.text});
}

class ClearFilter extends StocksSummaryEvent {
  ClearFilter();
}

class HandleConnectivityChange extends StocksSummaryEvent {
  final ConnectivityState connectivityState;
  HandleConnectivityChange(this.connectivityState);
}
