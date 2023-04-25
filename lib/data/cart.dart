import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  String imageUrl;

  Product(this.name, this.price, this.imageUrl);
}

class CategoryWidgetes extends StatefulWidget {
  @override
  _CategoryWidgetesState createState() => _CategoryWidgetesState();
}

class _CategoryWidgetesState extends State<CategoryWidgetes>
    with SingleTickerProviderStateMixin {
  List<Product> _coffeeProducts = [
    Product('Latte', 3.5, 'https://picsum.photos/id/237/200/300'),
    Product('Cappuccino', 3.0, 'https://picsum.photos/id/238/200/300'),
    Product('Espresso', 2.5, 'https://picsum.photos/id/239/200/300'),
  ];

  List<Product> _souvenirProducts = [
    Product('T-shirt', 20.0, 'https://picsum.photos/id/240/200/300'),
    Product('Mug', 10.0, 'https://picsum.photos/id/241/200/300'),
    Product('Keychain', 5.0, 'https://picsum.photos/id/242/200/300'),
  ];

  List<Product> _currentProducts = [];

  late AnimationController _animationController;
  late Animation<double> _animation;

  void _selectCategory(String category) {
    setState(() {
      if (category == 'Coffee') {
        _currentProducts = _coffeeProducts;
      } else if (category == 'Souvenir') {
        _currentProducts = _souvenirProducts;
      }
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();

    _currentProducts = _coffeeProducts;

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('Coffee and Souvenir'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                onTap: () => _selectCategory('Coffee'),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('Coffee'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectCategory('Souvenir'),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('Souvenir'),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 16),
            Expanded(
              child: FadeTransition(
                opacity: _animation,
                child: ListView.builder(
                  itemCount: _currentProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Image.network(
                                  _currentProducts[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentProducts[index].name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '\$${_currentProducts[index].price.toString()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
