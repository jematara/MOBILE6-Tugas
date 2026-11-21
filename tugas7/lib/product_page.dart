import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas7/cart_model.dart';
import 'package:tugas7/cart_page.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final products = [
    Product('Art Print A5', 'Doff laminated with holo foil', 'https://pbs.twimg.com/media/HUm6COeaQAEGBt3?format=webp&name=large'),
    Product('Photocard', 'Glossy, 2 sides', 'https://pbs.twimg.com/media/HPIbyxYbIAAVfg5?format=webp&name=large'),
    Product('Sticker sheet', 'UV Transparent', 'https://pbs.twimg.com/media/HXoIJQMbEAAD5C7?format=webp&name=large'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'pois-corner',
          style: GoogleFonts.montserrat(
            fontWeight: .bold,
            letterSpacing: -1
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Badge(
                  label: Text('${cart.totalItem}'),
                  isLabelVisible: cart.totalItem > 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage()
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart)
                  ),
                );
              }
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: .circular(10),
                child: Image.network(
                  product.gambar,
                  fit: .cover,
                ),
              ),
              title: Text(
                product.nama,
                style: GoogleFonts.montserrat(
                  fontWeight: .bold,
                  letterSpacing: -1,
                  color: Colors.brown
                ),
              ),
              subtitle: Text(
                product.deskripsi,
              ),
              trailing: IconButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false).add(product);
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.brown,
                )
              ),
            ),
          );
        },
      ),
    );
  }
}