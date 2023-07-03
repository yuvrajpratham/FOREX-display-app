import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/ForexData.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item})
      : assert(item != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("${item.name} pressed");
        },
        leading: Image.network(item.image),
        title: Text(item.name,style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),),
        
        trailing: Text(
          " \$${item.price1}     \$${item.price} ",
          textScaleFactor: 1.15,
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ),
    );
  }
}
