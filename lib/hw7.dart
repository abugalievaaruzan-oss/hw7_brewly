
import 'package:flutter/material.dart';

void main() {
  runApp(const BrewlyApp());
}

// Colors
const cream = Color(0xFFF8F4EE);
const brown = Color(0xFF654632);
const lightBrown = Color(0xFFEDE2D5);

// Coffee data model
class Coffee {
  final int id;
  final String name;
  final String description;
  final String image;
  final int price;
  final String category;

  const Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
  });
}

// Our coffee menu
const List<Coffee> coffees = [
  Coffee(
    id: 1,
    name: 'Caramel Latte',
    description:
        'Smooth espresso with steamed milk and sweet caramel. '
        'A perfect choice for a cozy morning.',
    image:
        'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800',
    price: 1890,
    category: 'Hot Coffee',
  ),
  Coffee(
    id: 2,
    name: 'Cappuccino',
    description:
        'Rich espresso topped with creamy milk foam. '
        'A classic Italian coffee experience.',
    image:
        'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?w=800',
    price: 1590,
    category: 'Hot Coffee',
  ),
  Coffee(
    id: 3,
    name: 'Iced Coffee',
    description:
        'Refreshing coffee served over ice with fresh milk. '
        'Made for sunny afternoons.',
    image:
        'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=800',
    price: 1990,
    category: 'Cold Coffee',
  ),
  Coffee(
    id: 4,
    name: 'Espresso',
    description:
        'A strong and aromatic shot of freshly brewed coffee. '
        'Simple, bold, and full of flavor.',
    image:
        'https://images.unsplash.com/photo-1510707577719-ae7c14805e3a?w=800',
    price: 1190,
    category: 'Hot Coffee',
  ),
];

// Main application
class BrewlyApp extends StatelessWidget {
  const BrewlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brewly',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brown,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: cream,
          foregroundColor: brown,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Home screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final Set<int> favorites = {};

  void toggleFavorite(int id) {
    setState(() {
      if (favorites.contains(id)) {
        favorites.remove(id);
      } else {
        favorites.add(id);
      }
    });
  }

  void openDetails(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          coffee: coffee,
          isFavorite: favorites.contains(coffee.id),
          onFavorite: () => toggleFavorite(coffee.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BREWLY',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          buildMenu(),
          buildFavorites(),
          buildProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: brown,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Tab 1: Coffee menu
  Widget buildMenu() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: brown,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.coffee,
                color: Colors.white,
                size: 34,
              ),
              SizedBox(height: 14),
              Text(
                'Your daily cup\nof happiness.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Fresh coffee. Warm moments.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'Our Coffee',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: brown,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Handcrafted with love',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 15),
        ...coffees.map((coffee) => coffeeCard(coffee)),
      ],
    );
  }

  // Tab 2: Saved coffee
  Widget buildFavorites() {
    final saved = coffees
        .where((coffee) => favorites.contains(coffee.id))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Your Favorites',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: brown,
          ),
        ),
        const SizedBox(height: 8),
        const Text('Your favorite coffee moments'),
        const SizedBox(height: 20),
        if (saved.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 90),
            child: Column(
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 65,
                  color: brown,
                ),
                SizedBox(height: 15),
                Text(
                  'No favorites yet',
                  style: TextStyle(fontSize: 19),
                ),
                SizedBox(height: 8),
                Text('Tap the heart to save your coffee!'),
              ],
            ),
          )
        else
          ...saved.map((coffee) => coffeeCard(coffee)),
      ],
    );
  }

  // Reusable coffee card
  Widget coffeeCard(Coffee coffee) {
    final saved = favorites.contains(coffee.id);

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => openDetails(coffee),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: coffeeImage(
                  coffee.image,
                  105,
                  110,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.category,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      coffee.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: brown,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${coffee.price} ₸',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => toggleFavorite(coffee.id),
                icon: Icon(
                  saved ? Icons.favorite : Icons.favorite_border,
                  color: saved ? Colors.red : brown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tab 3: Profile
  Widget buildProfile() {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const SizedBox(height: 22),
        const CircleAvatar(
          radius: 48,
          backgroundColor: lightBrown,
          child: Icon(
            Icons.person_outline,
            color: brown,
            size: 50,
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'Coffee Lover',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: brown,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Center(
          child: Text('Welcome to your Brewly profile'),
        ),
        const SizedBox(height: 30),
        const Card(
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Username'),
            subtitle: Text('Student User'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('Email'),
            subtitle: Text('student@example.com'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Saved Coffees'),
            trailing: Text('${favorites.length}'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            subtitle: Text('Profile preferences'),
          ),
        ),
        const SizedBox(height: 40),
        const Center(
          child: Text(
            'BREWLY • Made with love',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

// Detail screen
class DetailScreen extends StatefulWidget {
  final Coffee coffee;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const DetailScreen({
    super.key,
    required this.coffee,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool saved;

  @override
  void initState() {
    super.initState();
    saved = widget.isFavorite;
  }

  void toggleSaved() {
    widget.onFavorite();
    setState(() {
      saved = !saved;
    });
  }

  @override
  Widget build(BuildContext context) {
    final coffee = widget.coffee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: toggleSaved,
            icon: Icon(
              saved ? Icons.favorite : Icons.favorite_border,
              color: saved ? Colors.red : brown,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: coffeeImage(
                coffee.image,
                double.infinity,
                280,
              ),
            ),
            const SizedBox(height: 23),
            Text(
              coffee.category.toUpperCase(),
              style: const TextStyle(
                color: brown,
                letterSpacing: 2,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              coffee.name,
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${coffee.price} ₸',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'About this coffee',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              coffee.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: toggleSaved,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(17),
                ),
                icon: Icon(
                  saved ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  saved
                      ? 'Remove from Favorites'
                      : 'Add to Favorites',
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Image helper with fallback
Widget coffeeImage(
  String url,
  double width,
  double height,
) {
  return Image.network(
    url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: width,
        height: height,
        color: lightBrown,
        child: const Icon(
          Icons.local_cafe,
          color: brown,
          size: 55,
        ),
      );
    },
  );
}
