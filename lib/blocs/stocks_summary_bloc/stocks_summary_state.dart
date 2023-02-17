part of 'stocks_summary_bloc.dart';

@immutable
class StocksSummaryState extends Equatable {
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<StockSummaryReport>? stockSummaryReports;
  final List<StockSummaryReport>? reportsToShow;
  final bool loading;
  final bool offline;
  final bool invalidApiKey;
  bool get showStocks => !offline && !invalidApiKey;
  const StocksSummaryState({
    required this.stockSummaryReports,
    this.reportsToShow,
    required this.startDateTime,
    required this.endDateTime,
    this.offline = false,
    this.invalidApiKey = false,
    this.loading = true,
  });

  StocksSummaryState copyWith(
      {List<StockSummaryReport>? stockSummaryReports,
      List<StockSummaryReport>? reportsToShow,
      DateTime? startDateTime,
      DateTime? endDateTime,
      bool? offline,
      bool? invalidApiKey,
      bool? loading}) {
    return StocksSummaryState(
      stockSummaryReports: stockSummaryReports ?? this.stockSummaryReports,
      reportsToShow: reportsToShow ?? this.reportsToShow,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      offline: offline ?? this.offline,
      invalidApiKey: invalidApiKey ?? this.invalidApiKey,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        stockSummaryReports,
        reportsToShow,
        startDateTime,
        endDateTime,
        offline,
        invalidApiKey,
        loading
      ];
}
