class Company {
  Set<int>? id;
  String title = '';
  int? inn;
  double? price = 0;
  int? days;
  Company({required this.id, required this.title, this.inn, this.price, required int days});

  static Company fromJson(jdecoded) {
    //print(jdecoded['id'].runtimeType);
    var tmp = <int>{};
    for (var element in jdecoded['id']) {
      //print(element);
      tmp.add(element);
    }
    return Company(id: tmp, title: jdecoded['title'], inn: int.parse((jdecoded['inn'] ?? 0).toString()), price: double.parse((jdecoded['price'] ?? 0).toString()), days: int.parse((jdecoded['days'] ?? 0).toString()));
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id?.toList() ?? [],
      'title': title,
      'inn': inn,
      'price': price,
      'days': days,
    };
  }
}