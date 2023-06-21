import 'package:ecommerce_app/Screens/Cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/Screens/Cart/cart_page.dart';
import 'package:ecommerce_app/Screens/DashBoard/bloc/dashboard_bloc.dart';
import 'package:ecommerce_app/Screens/DashBoard/widgets/search_bar.dart';
import 'package:ecommerce_app/Screens/DashBoard/widgets/welcome_widget.dart';
import 'package:ecommerce_app/Screens/Product_details/product_detail.dart';
import 'package:ecommerce_app/repo/cart_repo.dart';
import 'package:ecommerce_app/repo/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/product.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  // final List<Product> products = ProductRepository.getAllProducts();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(FetchData());
    final DashboardBloc dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: appBar(),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DashboardLoadingState) {
            return CircularProgressIndicator();
          } else if (state is DashboardDataLoadedSuccessState) {
            final products = state.products;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                const SizedBox(height: 20),
                const WelcomeText(),
                // const CustomSearchBar(),
                const SizedBox(height: 20),

                /////// Grid view ////////

                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                    productId: product.id,
                                  )),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: Colors.blue,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 190,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(207, 229, 229, 229),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'INR ${product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    product.subDescription,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color.fromARGB(149, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is DashboardErrorState) {
            return Text(state.errorMessage);
          }
          return Container();
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            // Access bloc state to conditionally show/hide widgets in the AppBar
            if (state is DashboardDataLoadedSuccessState) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<CartBloc>(
                              create: (context) =>
                                  CartBloc(cartRepository: CartRepository()),
                              child: MyCartPage(),
                            )),
                  );
                },
                icon: const Icon(
                  Icons.shopping_bag,
                  color: Colors.grey,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
      title: const Text(
        'WalterMart',
        style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(149, 0, 0, 0)),
      ),
      centerTitle: false,
       leadingWidth: 0, 
    );
  }
}
// class DashBoardPage extends StatelessWidget {
//   DashBoardPage({super.key});

//   final List<Product> products = ProductRepository.getAllProducts();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFffffff),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyCartPage()),
//                 );
//               },
//               icon: const Icon(Icons.shopping_bag,color: Colors.grey,))
//         ],
//         title: const Text('YOLO'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         children: [
//           const SizedBox(height: 20),
//           const WelcomeText(),
//           const CustomSearchBar(),
//           const SizedBox(height: 20),

//           /////// Grid view ////////

//           GridView.builder(
//             shrinkWrap: true,
//             physics:
//                 const NeverScrollableScrollPhysics(), // Disable GridView scrolling
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10.0,
//               mainAxisSpacing: 10.0,
//               childAspectRatio: 2 / 3,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ProductDetail(
//                               productId: product.id,
//                             )),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     // color: Colors.blue,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             height: 190,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(0)),
//                             child: ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(10)),
//                                 child: Image.network(
//                                   product.imageUrl,
//                                   fit: BoxFit.fill,
//                                 )),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Container(
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(121, 255, 255, 255),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'INR ${product.price.toStringAsFixed(2)}',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               product.title,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             Text(
//                               product.subDescription,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: Color.fromARGB(149, 0, 0, 0)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
