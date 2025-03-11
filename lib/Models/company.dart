class Company {
  int? id;
  String title = '';
  int? inn;
  double? price = 0;
  int? countAccs = 1;
  Company({required this.id, required this.title, this.inn, this.price,  this.countAccs});
}