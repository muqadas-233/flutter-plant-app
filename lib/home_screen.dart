import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Plant> displayedPlants = plantList;
  String selectedCategory = "All";

  void filterPlants(String query) {
    final filtered = plantList.where((plant) {
      return plant.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedPlants = filtered;
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "All") {
        displayedPlants = plantList;
      } else {
        displayedPlants = plantList.where((p) => p.category == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Full white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What Kind\nOf Plants You Want",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.white.withValues(alpha: 77), blurRadius: 6),
                ],
              ),
              child: TextField(
                onChanged: filterPlants,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  suffixIcon: Icon(Icons.mic, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Category text buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["All", "Small", "Medium", "Hanging"]
                  .map((cat) => GestureDetector(
                onTap: () => filterByCategory(cat),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: cat == selectedCategory ? Colors.green[800] : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
                  .toList(),
            ),
            SizedBox(height: 16),

            // Plant Grid
            Expanded(
              child: GridView.builder(
                itemCount: displayedPlants.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final plant = displayedPlants[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => DetailsScreen(plant: plant),
                      ));
                    },
                    child: _buildPlantCard(plant),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard(Plant plant) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Top Row: Indoor text & heart icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Indoor",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Icon(Icons.favorite_border, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),

            // Image centered
            Expanded(
              child: Center(
                child: Image.asset(
                  plant.image,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 8),

            // Name and price
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "\$${plant.price}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                // Add button with white transparent background
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Dummy Plant class and data
class Plant {
  final String name;
  final String image;
  final double price;
  final String category;

  Plant({required this.name, required this.image, required this.price, required this.category});
}

final List<Plant> plantList = [
  Plant(name: "Ficus", image: "assets/ficus.png", price: 12.0, category: "Small"),
  Plant(name: "Cactus", image: "assets/cactus.png", price: 9.0, category: "Small"),
  Plant(name: "Samantha", image: "assets/samantha.png", price: 15.0, category: "Medium"),
  Plant(name: "Aloevera", image: "assets/aloevera.png", price: 8.0, category: "Small"),
];
