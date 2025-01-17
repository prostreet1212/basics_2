import 'package:basics_2/theme13/features/presentation/widgets/persons_list_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: (){
                showSearch(context: context, delegate: CustomeSearchDelegate());
              },
              ),
        ],
      ),
      body: PersonsList(),
    );
  }
}


