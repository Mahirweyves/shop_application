import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Shoe {
  final String name;
  final double price;
  final String imageUrl;
  final bool isMale;
  final String description;
  final List<int> availableSizes;

  Shoe({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isMale,
    required this.description,
    required this.availableSizes,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const EntryPage(),
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://www.shutterstock.com/image-photo/female-hands-different-stylish-shoes-260nw-2445641531.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Shoe> cartItems = [];
  final List<Shoe> favoriteItems = [];

  int selectedIndex = 0;
  bool showMen = true;

  final List<Shoe> allShoes = [
    Shoe(
      name: "Men's Sneakers",
      price: 99.99,
      imageUrl:
          'https://media.istockphoto.com/id/1350560575/photo/pair-of-blue-running-sneakers-on-white-background-isolated.jpg?s=612x612&w=0&k=20&c=A3w_a9q3Gz-tWkQL6K00xu7UHdN5LLZefzPDp-wNkSU=',
      isMale: true,
      description: 'Comfortable and stylish men’s sneakers.',
      availableSizes: [7, 8, 9, 10, 11],
    ),
    Shoe(
      name: "Women's Runners",
      price: 89.99,
      imageUrl:
          "https://www.skechers.ca/dw/image/v2/BDCN_PRD/on/demandware.static/-/Library-Sites-SkechersSharedLibrary/default/dwf0fb77e2/images/2023-Images/Lifestyle/Women-Walking.jpg?sw=356",
      isMale: false,
      description: 'Lightweight running shoes for women.',
      availableSizes: [6, 7, 8, 9],
    ),
    Shoe(
      name: "Men's Sneakers",
      price: 99.99,
      imageUrl:
          'https://media.istockphoto.com/id/1350560575/photo/pair-of-blue-running-sneakers-on-white-background-isolated.jpg?s=612x612&w=0&k=20&c=A3w_a9q3Gz-tWkQL6K00xu7UHdN5LLZefzPDp-wNkSU=',
      isMale: true,
      description: 'Comfortable and stylish men’s sneakers.',
      availableSizes: [7, 8, 9, 10, 11],
    ),
    Shoe(
      name: "Women's Runners",
      price: 89.99,
      imageUrl:
          "https://www.skechers.ca/dw/image/v2/BDCN_PRD/on/demandware.static/-/Library-Sites-SkechersSharedLibrary/default/dwf0fb77e2/images/2023-Images/Lifestyle/Women-Walking.jpg?sw=356",
      isMale: false,
      description: 'Lightweight running shoes for women.',
      availableSizes: [6, 7, 8, 9],
    ),
  ];

  void toggleCart(Shoe shoe) {
    setState(() {
      if (cartItems.contains(shoe)) {
        cartItems.remove(shoe);
      } else {
        cartItems.add(shoe);
      }
    });
  }

  void toggleFavorite(Shoe shoe) {
    setState(() {
      if (favoriteItems.contains(shoe)) {
        favoriteItems.remove(shoe);
      } else {
        favoriteItems.add(shoe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      buildHomeScreen(),
      buildFavoritesScreen(),
      buildCartScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text('Shoe Shop'),
        actions: [
          IconButton(
            onPressed: () => setState(() => showMen = !showMen),
            icon: Icon(showMen ? Icons.male : Icons.female),
          ),
        ],
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(Icons.favorite),
                if (favoriteItems.isNotEmpty)
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      favoriteItems.length.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(Icons.shopping_cart),
                if (cartItems.isNotEmpty)
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  Widget buildHomeScreen() {
    // List<Shoe> filtered = allShoes.where((s) => s.isMale == showMen).toList();
    List<Shoe> filtered = allShoes;
    return filtered.isEmpty
        ? const Center(child: Text("No shoes available."))
        : GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final shoe = filtered[index];
            return GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ProductDetailPage(
                            shoe: shoe,
                            toggleCart: toggleCart,
                            toggleFavorite: toggleFavorite,
                            isInCart: cartItems.contains(shoe),
                            isFavorite: favoriteItems.contains(shoe),
                          ),
                    ),
                  ),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      shoe.imageUrl,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(shoe.name),
                    Text('\$${shoe.price.toStringAsFixed(2)}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            favoriteItems.contains(shoe)
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () => toggleFavorite(shoe),
                        ),
                        IconButton(
                          icon: Icon(
                            cartItems.contains(shoe)
                                ? Icons.remove_shopping_cart
                                : Icons.add_shopping_cart,
                          ),
                          onPressed: () => toggleCart(shoe),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }

  Widget buildFavoritesScreen() {
    return favoriteItems.isEmpty
        ? const Center(child: Text("No liked shoes yet."))
        : ListView.builder(
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final shoe = favoriteItems[index];
            return ListTile(
              leading: Image.network(shoe.imageUrl, width: 50),
              title: Text(shoe.name),
              subtitle: Text('\$${shoe.price}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => toggleFavorite(shoe),
              ),
            );
          },
        );
  }

  Widget buildCartScreen() {
    double total = cartItems.fold(0, (sum, item) => sum + item.price);
    return cartItems.isEmpty
        ? const Center(child: Text("Nothing in cart."))
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final shoe = cartItems[index];
                  return ListTile(
                    leading: Image.network(shoe.imageUrl, width: 50),
                    title: Text(shoe.name),
                    subtitle: Text('\$${shoe.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => toggleCart(shoe),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Total: \$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
  }
}

class ProductDetailPage extends StatefulWidget {
  final Shoe shoe;
  final Function(Shoe) toggleCart;
  final Function(Shoe) toggleFavorite;
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
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool myIsFavorite = false;
  @override
  void initState() {
    myIsFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.shoe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(widget.shoe.imageUrl, height: 200),
            const SizedBox(height: 10),
            Text(widget.shoe.description),
            const SizedBox(height: 10),
            Text("Available Sizes: ${widget.shoe.availableSizes.join(', ')}"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    myIsFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(widget.isFavorite ? 'Liked' : 'Like'),
                  onPressed: () {
                    widget.toggleFavorite(widget.shoe);
                    setState(() {
                      myIsFavorite = !myIsFavorite;
                    });
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    widget.isInCart
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                  ),
                  label: Text(
                    widget.isInCart ? 'Remove from Cart' : 'Add to Cart',
                  ),
                  onPressed: () => widget.toggleCart(widget.shoe),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
