import 'dart:io';

import 'package:bills/Models/company.dart';
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
  List<Company> companies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: Text('Загрузить csv')
              ),
              // show preview of csv if it is loaded
              if (isCsvLoaded) Text(csvData.skip(1).take(10).toString()),
              if (isCsvLoaded) Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Количество строк: ${csvData.length}'),
                  Text('  ||  Количество столбцов: ${csvData[0].split(';').length}  ||  '),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isParsed = true;
                        companies = parseCsv(csvData);
                      });
                    },
                    child: Text('Парсинг в таблицу'),
                  ),
                ]
              ),
              if (isParsed) DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Название')),
                  DataColumn(label: Text('ИНН')),
                  DataColumn(label: Text('Цена')),
                  DataColumn(label: Text('Аккаунтов')),
                  DataColumn(label: Text('Действия')),
                ],
                rows: companies.map((e) => DataRow(cells: [
                  DataCell(Text(e.id.toString())),
                  DataCell(Text(e.title)),
                  DataCell(Text(e.inn.toString())),
                  DataCell(Text(e.price.toString())),
                  DataCell(Text(e.countAccs.toString())),
                  DataCell(Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: add edit company
                        },
                        child: Text('Изменить'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: add delete company
                        },
                        child: Text('Удалить'),
                      ),
                    ],
                  ))
                ])).toList(),
              ),
              if (isParsed) Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Количество компаний: ${companies.length}'),
                ]
              )
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
  
  List<Company> parseCsv(List<String> csvData) {
    List<Company> companies = [];
    for (var line in csvData.skip(1)) {
      List<String> cells = line.split(';');
      try {
        Company company = Company(
          id: int.parse(cells[0]),
          title: cells[1],
          inn: int.parse(cells[4]),
          price: double.parse(cells[5].toString().split(' ')[2]),
          //countAccs: 1,
        );
        companies.add(company);
        
      } catch (e) {
        print(e);
      }
    }
    return companies;
  }
}