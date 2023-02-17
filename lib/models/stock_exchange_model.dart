class StockExchange {
  final String name, acronym, mic, country, countryCode, city, website;
  const StockExchange(
      {required this.acronym,
      required this.city,
      required this.country,
      required this.countryCode,
      required this.mic,
      required this.name,
      required this.website});

  static StockExchange fromMap(Map<String, dynamic> data) {
    return StockExchange(
        acronym: data['acronym'],
        city: data['city'],
        country: data['country'],
        countryCode: data['country_code'],
        mic: data['mic'],
        name: data['name'],
        website: data['website']);
  }
}
