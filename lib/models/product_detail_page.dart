import 'package:flutter/material.dart';
import '../models/shoe.dart';

class ProductDetailPage extends StatelessWidget {
  final Shoe shoe;
  final void Function(Shoe) toggleCart;
  final void Function(Shoe) toggleFavorite;
  final bool isInCart;
  final bool isFavorite;

  const ProductDetailPage({
    super.key,
    required this.shoe,
    required this.toggleCart,
    required this.toggleFavorite,
    required this.isInCart,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(shoe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(shoe.imageUrl, height: 200)),
            const SizedBox(height: 20),
            Text(shoe.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Available sizes: ${shoe.availableSizes.join(', ')}'),
            const SizedBox(height: 10),
            Text(
              'Price: \$${shoe.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => toggleCart(shoe),
                  icon: Icon(
                    isInCart
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                  ),
                  label: Text(isInCart ? 'Remove from Cart' : 'Add to Cart'),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () => toggleFavorite(shoe),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
