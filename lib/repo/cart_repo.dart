import 'package:ecommerce_app/model/cart_model/cart.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:hive/hive.dart';

class CartRepository {
  static const String _cartBoxName = 'cart';
  final Map<String, Cart> _cartItems = {};
  Future<Box<Cart>> _getCartBox() async {
    if (!Hive.isBoxOpen(_cartBoxName)) {
      return await Hive.openBox<Cart>(_cartBoxName);
    } else {
      return Hive.box<Cart>(_cartBoxName);
    }
  }

  Future<void> addToCart({required Product product, required String id}) async {
    final box = await _getCartBox();

    final cartItems = box.values.cast<Cart>().toList();

    final existingCartItemIndex = cartItems.indexWhere((item) => item.id == id);

    if (existingCartItemIndex != -1) {
      // If the product already exists, increase its quantity
      final existingCartItem = cartItems[existingCartItemIndex];
      existingCartItem.quantity++;
    } else {
      // If the product doesn't exist, add it as a new cart item
      final cartItem = Cart(id: id, product: product, quantity: 1);
      await box.add(cartItem);
    }

    print('Item added to cart: ${product.title}');
  }

  //  Future<void> addToCart(
  //     {required Product product, required String id}) async {
  //   final box = await _getCartBox();

  //   final cartItem = Cart(id: id, product: product, quantity: 1);
  //   await box.add(cartItem);
  //   print('Item added to cart: ${product.title}');
  // }

  Future<void> updateCartItem(Cart updatedCartItem) async {
    final box = await _getCartBox();
    await box.put(updatedCartItem.id, updatedCartItem);
  }

  Future<void> removeItem(String id) async {
    final box = await _getCartBox();
    final cartItem = box.values.firstWhere((cart) => cart.id == id);
    if (cartItem != null) {
      await cartItem.delete();
    }
  }

  // Future<void> removeItem(String id) async {
  //   final box = await _getCartBox();
  //   final cartIndex = box.values.toList().indexWhere((cart) => cart.id == id);
  //   if (cartIndex != -1) {
  //     await box.deleteAt(cartIndex);
  //   }
  // }

  List<Cart> getCartItems() {
    final box = Hive.box<Cart>(_cartBoxName);
    return box.values.toList();
  }

  // List<Cart> getCartItems() {
  //   final box = Hive.box<Cart>(_cartBoxName);
  //  final _cartItems = box.values.toList();
  //  return _cartItems;
  // }

  double calculateTotalPrice() {
    final cartItems = getCartItems();

    double totalPrice = 0;

    for (var cartItem in cartItems) {
      totalPrice += cartItem.product.price * cartItem.quantity;
    }

    return totalPrice;
  }

  double calculateTotalPriceForCartItems(List<Cart> cartItems) {
    double totalPrice = 0;

    for (var cartItem in cartItems) {
      totalPrice += cartItem.product.price * cartItem.quantity;
    }

    return totalPrice;
  }

  Future<void> increaseQuantity(String id) async {
    final box = await _getCartBox();
    final cartIndex = box.values.toList().indexWhere((cart) => cart.id == id);
    if (cartIndex != -1) {
      final cart = box.getAt(cartIndex) as Cart?;
      if (cart != null) {
        final updatedCart = cart.copyWith(quantity: cart.quantity + 1);
        await box.putAt(cartIndex, updatedCart);
      }
    }
  }

  Future<void> decreaseQuantity(String id) async {
    final box = await _getCartBox();
    final cartIndex = box.values.toList().indexWhere((cart) => cart.id == id);
    if (cartIndex != -1) {
      final cart = box.getAt(cartIndex) as Cart?;
      if (cart != null && cart.quantity >= 1) {
        final updatedCart = cart.copyWith(quantity: cart.quantity - 1);
        await box.putAt(cartIndex, updatedCart);
      }

      if (cart != null && cart.quantity == 0) {
        await box.deleteAt(cartIndex);
      }
    }
  }

  Future<void> clearCart() async {
    final box = await _getCartBox();
    box.clear();
  }

  int getTotalItems() {
    final box = Hive.box<Cart>(_cartBoxName);
    return box.length;
  }
Future<void> deleteProductById(String id)async{
  final box = await _getCartBox();
  final cartIndex = box.values.toList().indexWhere((cart) => cart.id == id);
   await box.deleteAt(cartIndex);
}
}
  


  // static Future<void> increaseQuantity(String id) async {
  //   final box = await _getCartBox();
  //   final cartIndex = box.values.toList().indexWhere((cart) => cart.id == id);
  //   if (cartIndex != -1) {
  //     final cart = box.getAt(cartIndex) as Cart?;
  //     if (cart != null) {
  //       final updatedCart = cart.copyWith(quantity: cart.quantity + 1);
  //       await box.putAt(cartIndex, updatedCart);
  //     }
  //   }
  // }
  
// static Future<void> decreaseQuantity(String id) async {
//   final box = await _getCartBox();
//   final cartIndex = box.values.toList().indexWhere((cart) => cart.id == id);
//   if (cartIndex != -1) {
//     final cart = box.getAt(cartIndex) as Cart?;
//     if (cart != null && cart.quantity >= 1) {
//       final updatedCart = cart.copyWith(quantity: cart.quantity - 1);
//       await box.putAt(cartIndex, updatedCart);
//     }

//     if (cart != null && cart.quantity == 0) {
//       // Remove the cart item from the list
//       await box.deleteAt(cartIndex);
//     }
//   }
// }
// static double calculateTotalPrice(List<Cart> items) {
//   double totalPrice = 0;
//   int totalQuantity = 0;

//   for (var cartItem in items) {
//     totalPrice += cartItem.product.price * cartItem.quantity;
//     totalQuantity += cartItem.quantity;
//   }

//   print('Total Quantity: $totalQuantity');

//   return totalPrice;
// }