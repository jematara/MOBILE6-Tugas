import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas7/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'your cart',
          style: GoogleFonts.montserrat(
            fontWeight: .bold,
            letterSpacing: -1
          ),
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if(cart.items.isEmpty) {
            return Center(
              child: Text(
                'Your cart is still empty',
                style: GoogleFonts.montserrat(
                  fontWeight: .bold,
                  fontSize: 25,
                  color: Colors.brown
                ),
              )
            );
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final product = cart.items[index];
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
                      Provider.of<CartModel>(context, listen: false).remove(product);
                    },
                    icon: Icon(
                      Icons.remove_shopping_cart,
                      color: Colors.brown,
                    )
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}