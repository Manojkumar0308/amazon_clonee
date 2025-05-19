import 'package:amazon_clone/product/view/product_detail.dart';
import 'package:amazon_clone/product/view_model/product_view_model.dart';
import 'package:amazon_clone/utils/snackbar.dart';
import 'package:amazon_clone/widgets/custom_searchbox.dart';
import 'package:amazon_clone/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';


class ProductScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const ProductScreen({super.key,  required this.navigatorKey});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
          title: SearchBox(onChanged: (value)=>provider.setSearchQuery(value),)
        ),
      ),
      body:provider.products.isEmpty
          ? const Center(child: Text(''))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = provider.products[index];
          return ProductCard(name: product.name, brand: product.brand, category: product.category,price: product.price, imageUrl: product.imageUrl, onAddToCart: (){
            if(provider.isInCart(product.id)){
              showSnackBar(context, 'Item already in your cart');
            }else{
              provider.addToCart(product, '${user?.uid}');
              showSnackBar(context, 'Item added to your cart');
            }


          },onTap: (){
            Navigator.of(widget.navigatorKey.currentContext!).push(
                MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product.id,))
            );


          }, productId: product.id,);

        },
      ),
    );
  }
}
