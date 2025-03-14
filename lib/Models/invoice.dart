import 'dart:ffi';

import 'package:bills/Models/company.dart';

class Invoice {
  DateTime? creationDate = DateTime.now();
  DateTime? postedToElbaDate;
  Company? company;
  String? elbaInvoiceNumber;
  Double? invoiceSum;
  Map<String, Double>? invoiceItems;
  int nds = 5;
  Invoice({required this.company, required this.invoiceItems}) {
    double tmpInvoiceSum = 0;
    invoiceItems!.forEach((key, value) {
      tmpInvoiceSum += value as double;
    });
    invoiceSum = tmpInvoiceSum as Double?;
  }
}