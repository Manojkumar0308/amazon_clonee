import 'package:amazon_clone/checkout/view/checkout_screen.dart';
import 'package:amazon_clone/utils/media_query.dart';
import 'package:amazon_clone/utils/snackbar.dart';
import 'package:amazon_clone/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../product/view_model/product_view_model.dart';
import '../../utils/colors.dart';

class CartScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String userId;

  const CartScreen(
      {required this.navigatorKey, required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.appBarGradient,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset('assets/images/amazon_in.png', height: 35),
          ),
        ),
      ),
      body: FutureBuilder(
        future: provider.fetchCartItems(userId),
        builder: (context, snapshot) {
          final cartItems = provider.cartItems;

          if (cartItems.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }
          double totalPrice = cartItems.fold(
              0, (sum, item) => sum + item.price * item.quantity);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: context.screenWidth,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Subtotal: ₹${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CheckOutScreen( totalPrice: totalPrice),),);
                      },
                      child: Consumer<ProductViewModel>(
                        builder: (context, provider, child) {
                          int count = provider.totalCartCount;
                          return Container(
                            width: context.screenWidth,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.amber, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Center(
                                  child: Text(
                                "Proceed to Buy ( $count items )",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartItemCard(
                        imageUrl: item.imageUrl,
                        title: item.name,
                        brand: item.brand,
                        description: item.description,
                        price: item.price,
                        quantity: item.quantity,
                        onAdd: () {
                          provider.updateQuantity(
                              userId, item.pid, item.quantity + 1);
                        },
                        onRemove: () {
                          if (item.quantity > 1) {
                            provider.updateQuantity(
                                userId, item.pid, item.quantity - 1);
                          } else {
                            provider.removeFromCart(item.pid, userId);
                          }
                        },
                        onDelete: () {
                          provider.removeFromCart(item.pid, userId);
                          showSnackBar(context, 'Item removed from your Cart');
                        });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
