
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/model/item.dart';
import 'package:flower_app/pages/checkout.dart';
import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/pages/profile_page.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    final userrr = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(product: items[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -9,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(items[index].imgPath)),
                      ),
                    ]),
                    footer: GridTileBar(
// backgroundColor: Color.fromARGB(66, 73, 127, 110),
                      trailing: IconButton(
                          color: Color.fromARGB(255, 62, 94, 70),
                          onPressed: () {
                            carttt.add(items[index]);
                          },
                          icon: Icon(Icons.add)),

                      leading: Text("\$12.99"),

                      title: Text(
                        "",
                      ),
                    ),
                  ),
                );
              }),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/test.png"),
                          fit: BoxFit.cover),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/img/me.png"),
                    ),
                    accountEmail: Text("drluis999@gmail.com"),
                    accountName: Text("Welcome",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                  ListTile(
                      title: Text("Home"),
                      leading: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("My products"),
                      leading: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOut(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("Profile Page"),
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text("About"),
                      leading: Icon(
                        Icons.help_center,
                        color: Colors.black,
                      ),
                      onTap: () {}),
                  ListTile(
                      title: Text("Logout"),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 33),
                child: Text("Developed by Drluis999 © 2022",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    )),
              )
            ],
          ),
        ),
        appBar: AppBar(
          actions: [ProductsAndPrice()],
          backgroundColor: appbarGreen,
          title: Text("Home"),
        ));
  }
}
