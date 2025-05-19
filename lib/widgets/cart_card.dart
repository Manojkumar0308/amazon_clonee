import 'package:amazon_clone/utils/colors.dart';
import 'package:amazon_clone/utils/media_query.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String brand;
  final String description;
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final screenHeight = context.screenHeight;
    return Card(
      color: Colors.grey.shade50,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: screenHeight*0.15,
                  width: screenWidth * 0.3,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 40),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AppColors.secondaryColor, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onRemove,
                          child: const Icon(
                            Icons.remove,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12,),
                        Text(quantity.toString(),
                            style: const TextStyle(fontSize: 16),),
                        const SizedBox(width: 12,),
                        InkWell(
                          onTap: onAdd,
                          child: const Icon(
                            Icons.add,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  description.isEmpty?Container():Text(description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),),
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                           fontSize: 14)),
                  const SizedBox(height: 2),

                  Text('Brand: $brand',
                      style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 8),
                  Text("₹${price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  const SizedBox(height: 4),
                  const Text('In Stock',
                      style: TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.w400),),
                  const SizedBox(height: 4),
                  const Text('10 Days Returnable',
                    style: TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.w400),),


                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onDelete,
                        child: Container(
                          width: screenWidth*0.2,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500,width: 1),borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(child: Text('Delete',style: TextStyle(fontSize: 14),),),
                          ),),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          // width: screenWidth*0.2,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500,width: 1),borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(child: Text('Save for later',style: TextStyle(fontSize: 14),),),
                          ),),
                      ),
                    ],
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
