import 'package:basalt_stocks_app/models/stock_exchange_model.dart';

class StockTicker {
  final String name, symbol;
  final bool hasIntraday, hasEod;
  final String? country;
  final StockExchange stockExchange;

  const StockTicker({
    required this.name,
    required this.symbol,
    required this.hasIntraday,
    required this.hasEod,
    required this.stockExchange,
    this.country,
  });

  static StockTicker fromMap(Map<String, dynamic> data) {
    return StockTicker(
      name: data['name'],
      symbol: data['symbol'],
      hasIntraday: data['has_intraday'],
      hasEod: data['has_eod'],
      stockExchange: StockExchange.fromMap(data['stock_exchange']),
      country: data['country'],
    );
  }
}
