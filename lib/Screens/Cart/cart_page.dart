import 'package:ecommerce_app/Screens/Cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/Screens/Cart/widgets/bottom_sheet.dart';
import 'package:ecommerce_app/Screens/Cart/widgets/checkout.dart';
import 'package:ecommerce_app/Screens/Cart/widgets/product_tile.dart';
import 'package:ecommerce_app/Screens/DashBoard/bloc/dashboard_bloc.dart';
import 'package:ecommerce_app/Screens/DashBoard/dash_board.dart';
import 'package:ecommerce_app/model/cart_model/cart.dart';
import 'package:ecommerce_app/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(FetchCartEvent());

    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        if (state is CartLoadedState) {
          final List<Cart> cartItems = state.cartItems;

          final cartRepository = CartRepository();
          final double totalPrice = cartRepository.calculateTotalPrice();

          if (cartItems.isEmpty) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(240, 247, 247, 247),
              appBar: appBar(context),
              body: const Center(
                child: Text('Try Adding some products :)'),
              ),
            );
          }
          return Scaffold(
              backgroundColor: const Color.fromARGB(240, 247, 247, 247),
              appBar: appBar(context),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return ProductTile(
                          cartItem: cartItem,
                          totalPrice: totalPrice,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 280),
                ],
              ),
              bottomSheet: BottomSheetDetail(totalPrice: totalPrice));
        } else if (state is CartErrorState) {
          return Text('Error loading cart items');
        } else {
          return const Scaffold(
              body: Center(child: Text('Try Adding some products :)')));
        }
      },
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Cart Details',
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: const Color(0xFFf2f2f2),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => DashboardBloc(),
                          child: DashBoardPage()),
                    ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.green,
              )),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: const Color(0xFFf2f2f2),
          child: IconButton(
              onPressed: () async {
                final cartRepository = CartRepository();
                cartRepository.clearCart();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.green,
              )),
        ),
      ],
    );
  }
}
 // void _onDeleteCartItem() {
  //   setState(() {
  //     cartItems.removeWhere((item) => item.quantity == 0);
  //     cartItemsNotifier.value = List<Cart>.from(cartItems);
  //     CartRepository.calculateTotalPrice(cartItems);
  //   });
  // }


// class MyCartPage extends StatefulWidget {
//   const MyCartPage({Key? key}) : super(key: key);

//   @override
//   State<MyCartPage> createState() => _MyCartPageState();
// }

// final List<Cart> cartItems = CartRepository.getCartItems();
// final ValueNotifier<List<Cart>> cartItemsNotifier =
//     ValueNotifier<List<Cart>>(cartItems);

// class _MyCartPageState extends State<MyCartPage> {
//   void _onDeleteCartItem() {
//     setState(() {
//       cartItems.removeWhere((item) => item.quantity == 0);
//       cartItemsNotifier.value = List<Cart>.from(cartItems);
//       CartRepository.calculateTotalPrice(cartItems);
//     });
//   }

//   @override
//   void initState() {
//     fetchCartItems();
//     super.initState();
//   }

//   Future<void> fetchCartItems() async {
//     final updatedItems = await CartRepository.getCartItems();
//     setState(() {
//       cartItems.clear();
//       cartItems.addAll(updatedItems);
//     });
//     cartItemsNotifier.value = List<Cart>.from(cartItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double totalPrice = CartRepository.calculateTotalPrice(cartItems);

//     if (cartItems.isNotEmpty) {
//       return Scaffold(
//         backgroundColor: const Color.fromARGB(240, 247, 247, 247),
//         appBar: appBar(),
//         body: Column(
//           children: [
//             Expanded(
//                 child: ValueListenableBuilder<List<Cart>>(
//               valueListenable: cartItemsNotifier,
//               builder: (context, items, _) {
//                 return ListView.builder(
//                   // ...
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final cartItem = items[index];
//                     return ProductTile(
//                       cartItem: cartItem,
//                       onDelete: _onDeleteCartItem,
//                     );
//                   },
//                 );
//               },
//             )),
//             SizedBox(
//               height: 280,
//             )
//           ],
//         ),
//         bottomSheet: Container(
//           width: double.infinity,
//           height: 280,
//           color: const Color(0xFFf7f7f7),
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Use your discount code',
//                   style: const TextStyle(
//                       fontSize: 17, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                     color: Colors.grey[200],
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Enter coupon code',
//                             ),
//                           ),
//                         ),
//                         Icon(Icons.arrow_forward_ios_rounded,
//                             color: Colors.grey),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Total',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF676767)),
//                         ),
//                         ValueListenableBuilder<List<Cart>>(
//                           valueListenable: cartItemsNotifier,
//                           builder: (context, items, _) {
//                             final totalPrice =
//                                 CartRepository.calculateTotalPrice(items);
//                             return Text(
//                               '₹${totalPrice.toStringAsFixed(2)}',
//                               style: const TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Fee Delivery',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF676767)),
//                         ),
//                         Text(
//                           '₹ 0.00',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//                 const Divider(
//                   height: 20,
//                   thickness: 2,
//                   indent: 250,
//                   endIndent: 0,
//                   color: Colors.grey,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ChceckOut(
//                                       totalPrice: totalPrice,
//                                     )),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           foregroundColor: Colors.black,
//                           backgroundColor: const Color(0xFF139854),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           minimumSize: const Size(double.infinity, 1),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           child: Text(
//                             'Check Out',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 25),
//                     Container(
//                       height: 50,
//                       width: 110,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ValueListenableBuilder<List<Cart>>(
//                             valueListenable: cartItemsNotifier,
//                             builder: (context, items, _) {
//                               final totalPrice =
//                                   CartRepository.calculateTotalPrice(items);
//                               return Text(
//                                 '₹${totalPrice.toStringAsFixed(2)}',
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     } else {
//       return const Scaffold(
//           body: Center(child: Text('Try Adding some products :)')));
//     }
//   }

//   AppBar appBar() {
//     return AppBar(
//       backgroundColor: const Color(0xFFFFFFFF),
//       elevation: 0,
//       centerTitle: true,
//       title: const Text(
//         'Cart Details',
//         style:
//             const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//       ),
//       leading: CircleAvatar(
//         backgroundColor: const Color(0xFFf2f2f2),
//         child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back)),
//       ),
//       actions: [
//         CircleAvatar(
//           backgroundColor: const Color(0xFFf2f2f2),
//           child: IconButton(
//               onPressed: () {
//                 setState(() async {
//                   CartRepository.clearCart();
//                   await fetchCartItems();
//                 });
//               },
//               icon: const Icon(Icons.delete)),
//         ),
//       ],
//     );
//   }
// }
