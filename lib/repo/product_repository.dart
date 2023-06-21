import 'package:ecommerce_app/model/product.dart';
import 'package:hive/hive.dart';

class ProductRepository {
  static const String _productBoxName = 'products';

  static Future<Box<Product>> _getProductBox() async {
    return await Hive.openBox<Product>(_productBoxName);
  }

  static Future<void> addPreAddedProducts() async {
    final box = await _getProductBox();
    final preAddedProducts = [
      // Add your pre-added products here
      Product(
        id: '1',
        title: 'ZotacRTX 4090',
        imageUrl:
            'https://m.media-amazon.com/images/I/61Ubn8zSFoL._SL1000_.jpg',
        price: 2000,
        subDescription: 'GPU Memory: 8GB',
        decription:
            '''- Boost Clock 2520 MHz, NVIDIA Ada Lovelace Streaming Multiprocessors: Up to 2x performance and power efficiency, 4th Generation Tensor Cores: Up to 2X AI performance, 3rd Generation RT Cores: Up to 2X ray tracing performance.
- 24GB GDDR6X, 384-bit, 21 Gbps, PCIE 4.0; IceStorm 3.0 Advanced Cooling, SPECTRA 2.0 ARGB Lighting, 2x 110mm 1x 100mm dual ball bearing fans, FREEZE Fan Stop, Active Fan Control, Metal Backplate, Dual BIOS, Bundled GPU Support Stand''',
      ),
      Product(
        id: '2',
        title: 'Samsung 970 Plus',
        imageUrl:
            'https://m.media-amazon.com/images/I/71sVoMnX4KL._SL1500_.jpg',
        price: 3500,
        subDescription: 'Size: 1TB',
        decription:
            'Interface : NVMe (PCIe Gen 3.0 x 4). Voltage:3.3 V ± 5 % Allowable voltage. Operating Temperature : 0 - 70 ℃ Operating Temperature, 3,500MB/s Seq. Read, 3,200MB/s Seq. Write',
      ),
      Product(
          id: '3',
          title: 'Ryzen 9 7950X 3D',
          imageUrl:
              'https://m.media-amazon.com/images/I/51fRtv4UyBL._SL1500_.jpg',
          price: 3000,
          subDescription: 'CPU Hz: 3.2 GHz',
          decription:
              'AMD 7000 Series Ryzen 9 7950X 3D Desktop Processor 16 cores 32 Threads 144 MB Cache 4.2 GHz Upto 5.7 GHz AM5 Socket (100-100000908WOF)'),
      Product(
        id: '4',
        title: 'ASUS ROG Strix',
        imageUrl:
            'https://m.media-amazon.com/images/I/81x069mwcbL._SL1500_.jpg',
        price: 2600,
        subDescription: 'Supported CPUs: Intel and AMD',
        decription:
            'ASUS ROG Strix B550-F Gaming WiFi 6 AMD AM4 Socket for 3rd Gen AMD Ryzen ATX Gaming Motherboard with PCIe 4.0, teamed Power Stages, BIOS Flashback, Dual M.2 SATA 6 Gbps USB & Aura Sync (Ddr4)',
      ),
      // Add more pre-added products as needed
    ];

    await box.addAll(preAddedProducts);
  }

  static Product getProductById({required String id}) {
    final box = Hive.box<Product>(_productBoxName);
    return box.values.firstWhere((product) => product.id == id);
  }

  static Future<void> removePreAddedProducts() async {
    final box = await _getProductBox();
    await box.clear();
  }

  static List<Product> getAllProducts() {
    final box = Hive.box<Product>(_productBoxName);
    return box.values.toList();
  }
}
