import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = '2D09FBE4-DFDE-4862-AB8D-D8A83E116ABB';


const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Map<String, dynamic>? check;
  CoinData({this.currency,this.crypto});
  final String? currency,crypto;

  

  Future<dynamic> getCoinData() async {
    try {
      String? url = 'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apikey';
      http.Response response = await http.get(Uri.parse(url));
      print("check");
      // print(response.body);
      if (response.statusCode == 200) {
        String? val = response.body;
        // print(val);
        // print(jsonDecode(val));
        check = jsonDecode(val);
        print(check);
        return check;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    print(check);
  }
}
