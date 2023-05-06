import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';

import 'card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD', dropdownCurrency = 'USD';

  String? curRate1, curRate2, curRate3, cryptoCurrency;

  @override
  void initState() {
    super.initState();

    getValue();
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> itemslist = [];
    for (String currency in currenciesList) {
      var dropdownitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      itemslist.add(dropdownitem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: itemslist,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          dropdownCurrency = value;
          getValue();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickeritems = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      pickeritems.add(item);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickeritems,
    );
  }

  Future<void> getValue() async {
    Map<String, dynamic> coindata1 =
        await CoinData(currency: dropdownCurrency, crypto: cryptoList[0])
            .getCoinData();

    Map<String, dynamic> coindata2 =
        await CoinData(currency: dropdownCurrency, crypto: cryptoList[1])
            .getCoinData();

    Map<String, dynamic> coindata3 =
        await CoinData(currency: dropdownCurrency, crypto: cryptoList[2])
            .getCoinData();
    setState(() {
      curRate1 = Update(coindata1, cryptoList[0], curRate1);
      curRate2 = Update(coindata2, cryptoList[1], curRate2);
      curRate3 = Update(coindata3, cryptoList[2], curRate3);
    });
  }

  String? Update(
      Map<String, dynamic> coindata, String crypto, String? curRate) {
    setState(() {
      double? currencyRate = (coindata['rate']);
      int? realRate;

      realRate = currencyRate?.toInt();
      cryptoCurrency = crypto;

      curRate = realRate.toString();
      // print(curRate);
    });
    return curRate;
  }

  // String? val = getRate();
// We can use Text instead of Widget here because Text comes under Stateless Widget which itself comes under Widget

  @override
  Widget build(BuildContext context) {
    String? newval1 = curRate1;
    // print(curRate1);
    String? newval2 = curRate2;
    String? newval3 = curRate3;
    String? crypto = cryptoCurrency;

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CardCur(
              crypto: cryptoList[0],
              curRate: newval1,
              dropdownCurrency: dropdownCurrency,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CardCur(
              crypto: cryptoList[1],
              curRate: newval2,
              dropdownCurrency: dropdownCurrency,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CardCur(
              crypto: cryptoList[2],
              curRate: newval3,
              dropdownCurrency: dropdownCurrency,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
