import 'package:bills/Models/company.dart';
import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key, required this.company});
  final Company company;

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.title),
      ),
      body: Column(
        children: [
          Text('Invoice for ${widget.company.title}'),
          Text('Sum: ${widget.company.price}'),
          Text('month: ${DateTime.now().toLocal().month}'),
          ElevatedButton(onPressed: () {
            print('generate invoice');
            // generate invoice
            // generate invoice pdf
            genInvoicePdf(widget.company);
            // save invoice to file
            // save invoice to database
            // send invoice to company
          }, child: Text('generate invoice')),
        ],
      ),
    );
  }
  
  void genInvoicePdf(Company company) {
    // generate invoice pdf using pdf library
    
  }
}