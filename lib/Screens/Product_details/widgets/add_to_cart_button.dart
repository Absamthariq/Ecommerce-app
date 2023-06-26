import 'package:ecommerce_app/Screens/Cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/Screens/Cart/cart_page.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    Key? key,
    required this.prodcutId,
    required this.product,
  }) : super(key: key);

  final String prodcutId;
  final Product product;

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<CartBloc>(
                    create: (context) =>
                        CartBloc(cartRepository: CartRepository()),
                    child: MyCartPage(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  width: 2.5,
                  color: Colors.grey,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 30),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
             
              return Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(
                      AddToCartEvent(widget.product, widget.prodcutId),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added to cart'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF139854),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 1),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
