import 'package:yathaarth/models/product.dart';
import 'package:yathaarth/models/product_variation.dart';

class Products {
  static Products _instance = Products.internal();

  Products.internal();

  factory Products() => _instance;

  static List<Product> all() {
    return [
      Product(name: 'Jeera Crisps', code: 'JRCP', taxRate: '18', variations: [
        ProductVariation(
            weight: '30',
            unitPrice: {'partner': 8, 'retailer': 8.8, 'customer': 10},
            boxQuantity: 20,
            boxPrice: {'partner': 160, 'retailer': 176, 'customer': 200}),
        ProductVariation(
          weight: '100',
          unitPrice: {'partner': 23.8, 'retailer': 27, 'customer': 30},
          boxQuantity: 20,
          boxPrice: {'partner': 476, 'retailer': 540, 'customer': 600},
        )
      ]),
      Product(name: 'Nut Lite', code: 'NTLT', taxRate: '12', variations: [
        ProductVariation(
          weight: '25',
          unitPrice: {'partner': 8, 'retailer': 8.8, 'customer': 10},
          boxQuantity: 20,
          boxPrice: {'partner': 160, 'retailer': 176, 'customer': 200},
        ),
        ProductVariation(
          weight: '80',
          unitPrice: {'partner': 23.8, 'retailer': 27, 'customer': 30},
          boxQuantity: 20,
          boxPrice: {'partner': 476, 'retailer': 540, 'customer': 600},
        )
      ]),
      Product(name: 'Chocochip Muffin', code: 'CHMF', taxRate: '18', variations: [
        ProductVariation(
          weight: '25',
          unitPrice: {'partner': 3.8, 'retailer': 4.25, 'customer': 5},
          boxQuantity: 20,
          boxPrice: {'partner': 76, 'retailer': 85, 'customer': 100},
        ),
        ProductVariation(
          weight: '35',
          unitPrice: {'partner': 7.65, 'retailer': 8.5, 'customer': 10},
          boxQuantity: 20,
          boxPrice: {'partner': 153, 'retailer': 170, 'customer': 200},
        )
      ]),
      Product(name: 'Choco Energy Bites', code: 'CCEB', taxRate: '18', variations: [
        ProductVariation(
          weight: '15',
          unitPrice: {'partner': 7.65, 'retailer': 8.6, 'customer': 10},
          boxQuantity: 20,
          boxPrice: {'partner': 153, 'retailer': 172, 'customer': 200},
        )
      ]),
      Product(name: 'Classic Energy Bites', code: 'CLEB', taxRate: '18', variations: [
        ProductVariation(
          weight: '15',
          unitPrice: {'partner': 3.9, 'retailer': 4.3, 'customer': 5},
          boxQuantity: 20,
          boxPrice: {'partner': 78, 'retailer': 86, 'customer': 100},
        )
      ])
    ];
  }
}
