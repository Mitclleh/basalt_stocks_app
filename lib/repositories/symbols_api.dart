import 'dart:convert';
import 'package:basalt_stocks_app/constants.dart';
import 'package:basalt_stocks_app/models/end_of_day_report.dart';
import 'package:basalt_stocks_app/models/stock_ticker_model.dart';
import 'package:http/http.dart';

/*
Repository that interacts with the tickers endpoint, there is no local database in this application since I do not see the
need for it, but ISAR wouuld be a quick, easy and super effective solution for local data storage, along with a abstract repository
class that will interact with the api, and store the data locally for each class that extends it.
*/

class SymbolsRepository {
  static Future<List<StockTicker>?> all() async {
    var url = Uri.http(apiEndpoint, '/v1/tickers', {'access_key': apiKey});
    final Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> decodedData = jsonDecode(data);
      List<StockTicker> tickerList = (decodedData['data'] as List)
          .map((e) => StockTicker.fromMap(e))
          .toList();

      return tickerList;
    } else {
      return null;
    }
  }

  static Future<List<EndOfDayReport>?> fetch(List<String> symbols) async {
    var url = Uri.http(apiEndpoint, '/v1/eod',
        {'access_key': apiKey, 'symbols': symbols.join(',')});
    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        Map<String, dynamic> decodedData = jsonDecode(data);
        List<EndOfDayReport> reports = (decodedData['data'] as List)
            .map((e) => EndOfDayReport.fromMap(e))
            .toList();
        return reports;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
