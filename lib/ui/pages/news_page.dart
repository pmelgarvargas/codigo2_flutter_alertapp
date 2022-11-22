import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:codigo2_alerta/ui/pages/news_register_page.dart';
import 'package:codigo2_alerta/ui/widgets/textfield_custom_widget.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewsRegisterPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: kBrandPrimaryColor,
      ),

    );
  }
}
