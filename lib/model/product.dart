import 'package:hive/hive.dart';
part 'product.g.dart';
@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  double price;

  @HiveField(4)
  String decription;

  @HiveField(5)
  String subDescription;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.decription,
    required this.subDescription
  });
}
