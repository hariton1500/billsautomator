import 'dart:io';

import 'package:bills/Models/company.dart';
import 'package:bills/Pages/companypage.dart';
import 'package:bills/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool isCsvLoaded = false;
  List<String> csvData = [];
  bool isParsed = false;
  //List<Company> companies = [];
  String tmpToken = '', tmpElbaToken = '';

  @override
  Widget build(BuildContext context) {
    print(token);
    print(elbaToken);
    return Scaffold(
      appBar: AppBar(
        title: Text('Компаний: ${companies.length}'),
        actions: [
          ElevatedButton(
            onPressed: () {
              clearToken(key: 'token');
              setState(() {
                token = '';
              });
            },
            child: Text('clear token')
          ),
          ElevatedButton(
            onPressed: () {
              clearToken(key: 'albaToken');
              setState(() {
                elbaToken = '';
              });
            },
            child: Text('clear elba token')
          ),
        ],
      ),
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (token!.length < 5)
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Token'),
                      onChanged: (value) => tmpToken = value,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {saveToken(record: tmpToken, key: 'token');setState(() {
                      token = tmpToken;
                    });},
                    child: Text('Save'),
                  )
                ],
              ),
            if (elbaToken!.length < 5)
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Elba token'),
                      onChanged: (value) => tmpElbaToken = value,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {saveToken(record: tmpElbaToken, key: 'elbaToken');setState(() {
                      elbaToken = tmpElbaToken;
                    });},
                    child: Text('save'),
                  ),
                ],
              ),
            ElevatedButton(
                onPressed: () {
                  FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['csv'],
                  ).then((value) {
                    if (value != null) {
                      print(value.files.first.path);
                      setState(() {
                        isCsvLoaded = true;
                        csvData = readCsv(value.files.first);
                      });
                    }
                  });
                },
                child: Text('Загрузить csv')),
            // show preview of csv if it is loaded
            if (isCsvLoaded) Text(csvData.skip(1).take(1).toString()),
            if (isCsvLoaded)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Количество строк: ${csvData.length}'),
                Text(
                    '  ||  Количество столбцов: ${csvData[0].split(';').length}  ||  '),
                ElevatedButton(
                  onPressed: () {
                    parseCsv(csvData);
                    setState(() {
                      isParsed = true;
                    });
                    saveCompanies();
                  },
                  child: Text('Парсинг в таблицу'),
                ),
              ]),
            if (companies.isNotEmpty)
              DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Название')),
                  DataColumn(label: Text('ИНН')),
                  DataColumn(label: Text('Цена')),
                  DataColumn(label: Text('Аккаунтов')),
                  DataColumn(label: Text('Действия')),
                ],
                rows: companies
                    .take(10)
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.id.toString())),
                          DataCell(Text(e.title)),
                          DataCell(Text(e.inn.toString())),
                          DataCell(Text(e.price.toString())),
                          DataCell(Text(e.id!.length.toString())),
                          DataCell(Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // TODO: add edit company
                                },
                                child: Text('Open'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // open in new page
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CompanyPage(company: e),
                                  ));
                                },
                                child: Text('Open'),
                              ),
                            ],
                          ))
                        ]))
                    .toList(),
              ),
            if (isParsed)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Количество компаний: ${companies.length}'),
              ])
          ],
        ),
      ),
    ));
  }

  List<String> readCsv(PlatformFile f) {
    String path = f.path!;
    File file = File(path);
    List<String> lines = file.readAsLinesSync();
    return lines;
  }

  parseCsv(List<String> csvData) {
    //Set<Company> companies = [];
    for (var line in csvData.skip(1)) {
      List<String> cells = line.split(';');
      try {
        print(cells);
        Company company = Company(
            id: <int>{int.parse(cells[0])},
            title: cells[1],
            inn: int.parse(cells[4]),
            price: double.parse(cells[5].toString().split(' ')[2]),
            days: int.parse(cells[6])
            //countAccs: 1,
            );
        companies.add(company);
      } catch (e) {
        print('error');
      }
    }
    //return companies;
  }
}
