import 'package:ecommerce_app/Screens/Cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/Screens/Product_details/bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/Screens/Product_details/widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.productId}) : super(key: key);
  final String productId;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> with SingleTickerProviderStateMixin {
  late final ProductDetailBloc productDetailBloc;

  @override
  void initState() {
    super.initState();
    productDetailBloc = ProductDetailBloc();
    productDetailBloc.add(FetchProductDetailEvent(widget.productId));
  }

  @override
  void dispose() {
    productDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) => productDetailBloc,
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            return Scaffold(
              appBar: appBar(context),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ProductImageWidget(
                      imageUrl: state.product.imageUrl,
                    ),
                    const SizedBox(height: 20),
                    ProductTitleDetails(
                      price: state.product.price,
                      title: state.product.title,
                    ),
                    const SizedBox(height: 20),
                    productDescription(description: state.product.decription)
                  ],
                ),
              ),
              bottomSheet: BlocProvider<CartBloc>(
                create: (context) => CartBloc(cartRepository: CartRepository()),
                child: BottomSheetWidget(
                  prodcutId: state.product.id,
                  product: state.product,
                ),
              ),
            );
          } else if (state is ProductDetailLoading) {
            return CircularProgressIndicator();
          } else {
            // Initial/default state, show placeholder or empty state
            return Text('No product detail available');
          }
        },
      ),
    );
  }
}

  

  Text productDescription({required String description}) {
    return Text(description);
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Details',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Color.fromARGB(29, 0, 0, 0),
          foregroundColor: Colors.white,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
      ),
    );
  }


class ProductTitleDetails extends StatelessWidget {
  const ProductTitleDetails({
    super.key,
    required this.title,
    required this.price,
  });
  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              price.toString(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text('4.8 | sold 250+')
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_rounded,
              size: 30,
            ))
      ],
    );
  }
}

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
