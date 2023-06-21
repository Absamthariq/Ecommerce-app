import 'package:ecommerce_app/Screens/Cart/bloc/cart_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/cart_model/cart.dart';

class ProductTile extends StatefulWidget {
  ProductTile({Key? key, required this.cartItem, required this.totalPrice})
      : super(key: key);

  final Cart cartItem;
  final double totalPrice;

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFFf5f5f5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.cartItem.product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        widget.cartItem.product.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    bloc: cartBloc,
                    builder: (context, state) {
                      if (state is CartLoadedState) {
                        final cartItems = state.cartItems;
                        final updatedCartItem = cartItems.firstWhere(
                          (item) => item.id == widget.cartItem.id,
                          orElse: () => widget.cartItem,
                        );
                        quantity = updatedCartItem.quantity;
                        print('quantity updated');
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    cartBloc.add(
                                      DecreaseQuantityEvent(widget.cartItem.id),
                                    );
                                    print(quantity);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 15,
                                  ),
                                ),
                              ),
                              Text('$quantity'),
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    cartBloc.add(
                                      IncreaseQuantityEvent(widget.cartItem.id),
                                    );
                                    print(quantity);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // void _increaseQuantity() {
  //   BlocProvider.of<CartBloc>(context)
  //       .add(IncreaseQuantityEvent(cartItem.id));
  // }

  // void _decreaseQuantity() {
  //   BlocProvider.of<CartBloc>(context)
  //       .add(DecreaseQuantityEvent(cartItem.id));
  // }


// void _increaseQuantity() async {
//   setState(() async {
//     await CartRepository.increaseQuantity(widget.cartItem.id);
//     widget.cartItem.quantity += 1;
//     widget.totalPrice = await CartRepository.calculateTotalPrice();
//     print(widget.cartItem.quantity);
//     print('Increase pressed');
//   });
// }
// void _decreaseQuantity() async {
//   final updatedQuantity = widget.cartItem.quantity - 1;
//   if (updatedQuantity >= 0) {
//     setState(() async {
//       widget.cartItem.quantity = updatedQuantity;

//       if (updatedQuantity == 0) {
//         await CartRepository.removeItem(widget.cartItem.id);
//         print('deleted');
//       } else {
//         // Update the quantity in the storage
//         await CartRepository.decreaseQuantity(widget.cartItem.id);
//       }

//       final updatedCartItems = await CartRepository.getCartItems();
//       setState(() {
//         cartItems.clear();
//         cartItems.addAll(updatedCartItems);
//       });
//       widget.totalPrice = await CartRepository.calculateTotalPrice();
//     });
//   }
// }

  // Retrieve the latest cart items after the update
  //   final updatedCartItems =  CartRepository.getCartItems();
  //   setState(() {
  //     cartItems.clear();
  //     cartItems.addAll(updatedCartItems);
  //   });
  // }

// class ProductTile extends StatefulWidget {
//   const ProductTile({Key? key, required this.cartItem}) : super(key: key);

//   final Cart cartItem;

//   @override
//   State<ProductTile> createState() => _ProductTileState();
// }

// class _ProductTileState extends State<ProductTile> {
// void _increaseQuantity() {
//     setState(() {
//       CartRepository.increaseQuantity(widget.cartItem.id);
//       widget.cartItem.quantity += 1;
//       print(widget.cartItem.quantity);
//       print('Increase pressed');
//     });
//   }

// void _decreaseQuantity() async {
//   setState(() {
//     CartRepository.decreaseQuantity(widget.cartItem.id);
//     if (widget.cartItem.quantity > 0) {
//       widget.cartItem.quantity -= 1;
//       print(widget.cartItem.quantity);
//       print('Decrease pressed');
//     } else {
//       // Remove the cart item from the list
//       CartRepository.removeItem(widget.cartItem.id);
//       print('deleted');
//     }
//   });

//   // Retrieve the latest cart items after the update
//   final updatedCartItems = await CartRepository.getCartItems();
//   setState(() {
//     cartItems.clear();
//     cartItems.addAll(updatedCartItems);
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 160,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: 130,
//                 height: 130,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFf5f5f5),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Wrap(
//                     direction: Axis.vertical,
//                     children: [
//                       Text(
//                         widget.cartItem.product.title,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const Text(
//                         'Descriptiom',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       const SizedBox(width: 2),
//                       Text(
//                         '₹${widget.cartItem.product.price.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Container(
//                         width: 110,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFf5f5f5),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CircleAvatar(
//                               child: IconButton(
//                                 onPressed: _decreaseQuantity,
//                                 icon: const Icon(
//                                   Icons.remove,
//                                   size: 15,
//                                 ),
//                               ),
//                             ),
//                             Text('${widget.cartItem.quantity}'),
//                             CircleAvatar(
//                               child: IconButton(
//                                 onPressed: _increaseQuantity,
//                                 icon: const Icon(
//                                   Icons.add,
//                                   size: 15,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

