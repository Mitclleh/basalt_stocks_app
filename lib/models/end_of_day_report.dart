class EndOfDayReport {
  final double? open,
      high,
      low,
      close,
      volume,
      adjHigh,
      adjLow,
      adjClose,
      adjOpen,
      adjVolume;
  final String symbol, exchange;

  final DateTime date;
  EndOfDayReport(
      {required this.open,
      required this.close,
      required this.symbol,
      required this.volume,
      required this.low,
      required this.high,
      required this.adjVolume,
      required this.exchange,
      required this.date,
      required this.adjClose,
      required this.adjHigh,
      required this.adjOpen,
      required this.adjLow});

  static EndOfDayReport fromMap(Map<String, dynamic> data) {
    return EndOfDayReport(
        open: data["open"],
        high: data["high"],
        low: data["low"],
        close: data["close"],
        volume: data["volume"],
        adjHigh: data["adj_high"],
        adjLow: data["adj_low"],
        adjClose: data["adj_close"],
        adjOpen: data["adj_open"],
        adjVolume: data["adj_volume"],
        symbol: data["symbol"],
        exchange: data["exchange"],
        date: DateTime.parse(data["date"]));
  }
}
