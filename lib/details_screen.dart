import 'package:flutter/material.dart';
import 'home_screen.dart';

class DetailsScreen extends StatefulWidget {
  final Plant plant;

  const DetailsScreen({super.key, required this.plant});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // 🪴 Plant Image
              SizedBox(
                height: 420,
                child: Image.asset(widget.plant.image),
              ),
              const SizedBox(height: 10),

              // 🪴 Name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.plant.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // 🪴 Price
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Regular Price \$${widget.plant.price}",
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ),
              ),
              const SizedBox(height: 16),

              // ➕➖ Quantity & ⭐️ Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Counter
                  Row(
                    children: [
                      _greenSquareButton(Icons.remove, _decreaseQuantity),
                      const SizedBox(width: 10),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _greenSquareButton(Icons.add, _increaseQuantity),
                    ],
                  ),

                  // ⭐️ Stars
                  Row(
                    children: List.generate(
                      5,
                          (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 📝 Description
              const Text(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout...",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: 'Roboto', // Custom font if added
                ),
              ),

              const SizedBox(height: 20),

              // 🛒 Buy Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900], // Dark green
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Action with selected quantity
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added $_quantity item(s) to cart')),
                    );
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Green Square Button used for + and -
  Widget _greenSquareButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.green[900], // Dark green
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
