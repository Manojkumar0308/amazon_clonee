import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../product/view/product_detail.dart';
import '../../product/view_model/product_view_model.dart';
import '../../utils/colors.dart';
import '../../utils/snackbar.dart';
import '../../widgets/product_card.dart';

class CategoryScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const CategoryScreen({super.key, required this.navigatorKey});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final provider = Provider.of<ProductViewModel>(context);
    final categories = ['All', ...provider.uniqueCategories.toSet()];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  final category = index == 0 ? 'All' : provider.uniqueCategories[index - 1];
                  final isSelected = provider.selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      provider.setSelectedCategory(category);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child:provider.filteredCategoryProducts.isEmpty
                ? const Center(child: Text("No products found"))
                : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: provider.filteredCategoryProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, index) {
                final product = provider.filteredCategoryProducts[index];
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
          ),
        ],
      ),
    );
  }
}
