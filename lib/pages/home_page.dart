

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_application_1/models/ForexData.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import '../models/ForexData.dart';
import '../widgets/item_widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/themes.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";
  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  final  banklogo="assets/images/IDBI-Bank-logo.png";
  void refreshApp() {
    setState(() {
      // Update any state variables or data that need to be refreshed
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    
  }
  loadData() async {
    await Future.delayed(Duration(seconds:2));
   final catalogJson =
        await rootBundle.loadString("assets/files/ForexData.json");
        print(catalogJson);
    final decodedData = jsonDecode(catalogJson);

    var productsData = decodedData["products"];
    
    CatalogModel.items = List.from(productsData)
    .map<Item>((item) =>Item.fromMap(item))
    .toList();
    setState(() {});
  }
 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: MyTheme.creamColor,
    body: SafeArea(
      child: Container(
        padding: Vx.m32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CatalogHeader(bankLogo: banklogo),

            if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
              CatalogList().expand()
            else
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    ),
    drawer: MyDrawer(),
  );
}
}


  class CatalogHeader extends StatelessWidget {
    final String bankLogo;

  CatalogHeader({required this.bankLogo});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            Image.asset(bankLogo).box.rounded.p1.color(MyTheme.creamColor).make().p1().wh40(context).h10(context),
            SizedBox(width: 40), // Add some spacing between the texts
          ],
        ),
        MainBar(),
        

        
      ],
   
    );
  }
  }


class CatalogList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return CatalogItem(catalog: catalog);
      },
    );
  }
}
class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({
    required this.catalog,
  });

  @override
  Widget build(BuildContext context) {
    return VxBox(
      
      child:Row(
        children: [
        CatalogImage(image:catalog.image,),
        Expanded(child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            
          catalog.name.text.xl2.lg.color(MyTheme.darkBluishColor).bold.make(),
          30.widthBox,
          Price(catalog: catalog),

          

           10.widthBox,
            Price1(catalog: catalog),

          
          ],

        ))
        ],)
    ).white.rounded.square(100).make().py16();
  }
}
class CatalogImage extends StatelessWidget {
final String image;

  const CatalogImage({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return   Image.network(image).box.rounded.p8.color(MyTheme.creamColor).make().p16().w32(context);
  }
}

class Price extends StatelessWidget {
  final Item catalog;

  const Price({required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Container(
       child: "\$${catalog.price}".text.bold.xl.make(),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 12),
    );
  }
}
class Price1 extends StatelessWidget {
  final Item catalog;

  const Price1 ({required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Container(
       child: "\$${catalog.price1}".text.bold.xl.make(),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 12),
    );
  }
}
class MainBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 215, 245, 248),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          "   Currency".text.bold.color(Color(0xff403b58)).xl.make(),
          "       Code".text.bold.color(Color(0xff403b58)).xl.make(),
          "          Buy".text.bold.color(Colors.green).xl.make(),
          "          Sell".text.bold.color(Colors.red).xl.make(),
        ],
      ),
    );
  }
}


