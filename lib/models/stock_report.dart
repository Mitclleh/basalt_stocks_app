import 'package:basalt_stocks_app/models/end_of_day_report.dart';
import 'package:basalt_stocks_app/models/stock_ticker_model.dart';

class StockSummaryReport {
  final String symbol, name, exchange;
  final double high, low, volume, firstOpen, lastClose;
  final DateTime startDateTime, endDateTime;

  double get percentageChange => calculatePercentageChange();

  double calculatePercentageChange() {
    return ((lastClose - firstOpen) / firstOpen) * 100;
  }

  StockSummaryReport(
      {required this.symbol,
      required this.firstOpen,
      required this.lastClose,
      required this.name,
      required this.exchange,
      required this.high,
      required this.low,
      required this.volume,
      required this.startDateTime,
      required this.endDateTime});

  static StockSummaryReport? fromEndOfDayReports(
      List<EndOfDayReport> endOfDayReports, StockTicker ticker) {
    List<EndOfDayReport>? symbolReports = endOfDayReports
        .where(
          (element) => element.symbol == ticker.symbol,
        )
        .toList();
    if (symbolReports.isEmpty) {
      return null;
    }
    symbolReports.sort(
      (a, b) {
        return a.date.isBefore(b.date) ? 1 : 0;
      },
    );
    double high =
        symbolReports.map((e) => e.high).reduce((a, b) => a! > b! ? a : b)!;
    double low =
        symbolReports.map((e) => e.high).reduce((a, b) => a! < b! ? a : b)!;

    return StockSummaryReport(
        symbol: ticker.symbol,
        exchange: symbolReports[0].exchange,
        high: high,
        low: low,
        firstOpen: symbolReports.first.open!,
        lastClose: symbolReports.last.close!,
        name: ticker.name,
        volume: symbolReports.last.volume!,
        startDateTime: symbolReports.first.date,
        endDateTime: symbolReports.last.date);
  }
}
