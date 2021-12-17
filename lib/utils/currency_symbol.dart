import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

currency(context, ISO) {
  Locale locale = Localizations.localeOf(context);

  var format = NumberFormat.simpleCurrency(
      locale: Platform.localeName, name: ISO.toString());
  // print(format.currencyName);
  // print(format.symbols);
  // print(format.currencySymbol);

  return format;
}
