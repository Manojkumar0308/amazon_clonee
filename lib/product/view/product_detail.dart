import 'package:amazon_clone/product/view/product_review.dart';
import 'package:amazon_clone/product/view_model/product_view_model.dart';
import 'package:amazon_clone/utils/media_query.dart';
import 'package:amazon_clone/widgets/custombutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../checkout/view/checkout_screen.dart';
import '../../utils/colors.dart';
import '../../utils/snackbar.dart';
import '../model/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
            child: Image.asset(
              'assets/images/amazon_in.png',
              height: 35,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future:
            FirebaseDatabase.instance.ref("products/${widget.productId}").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data?.value == null) {
            return const Center(child: Text("Product not found"));
          }

          final data = Map<String, dynamic>.from(snapshot.data!.value as Map);
          final product = Product.fromMap(data, widget.productId);
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  child: SizedBox(
                    height: context.screenHeight * 0.05,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          imageUrl: data['imageUrl'],
                          fit: BoxFit.cover,
                          placeholder: (ctx, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (ctx, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${data['name']} | ${data['brand']} | ${data['category']}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "₹${data['price'].toStringAsFixed(2)}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Brand: ${data['brand']}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Product: ${data['name']}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${data['description']}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: context.screenHeight * 0.40,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: data['imageUrl'],
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (ctx, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ReviewSection(),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Quantity: 1',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "₹${data['price'].toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Inclusive of all taxes',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                      text: 'Add to Cart',
                      onTap: () {
                        final provider = Provider.of<ProductViewModel>(context,
                            listen: false);
                        if (provider.isInCart(product.id)) {
                          showSnackBar(context, 'Item already in your cart');
                        } else {
                          provider.addToCart(product, '${user?.uid}');
                          showSnackBar(context, 'Item added to your cart');
                        }
                      },
                      color: AppColors.secondaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                      text: 'Buy Now',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                CheckOutScreen(totalPrice: product.price),
                          ),
                        );
                      },
                      color: AppColors.backgroundColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
