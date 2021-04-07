import 'package:flutter/material.dart';
//import 'package:products/views/add_product_view.dart';

import 'add_mobile_view.dart';
import 'add_stationary_view.dart';

class TypeView extends StatefulWidget {
  @override
  _TypeViewState createState() => _TypeViewState();
}

class _TypeViewState extends State<TypeView> {
  String type = 'Mobile';

  List<String> types = [
    "Stationary",
    "Mobile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Card(
          elevation: 10,
          child: Container(
            height: 200,
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Select type of product : '),
                    DropdownButton(
                      value: type,
                      items: types.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        'Select a type',
                      ),
                      onChanged: (value) {
                        setState(() {
                          type = value;
                        });
                      },
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text(
                    'Next',
                  ),
                  onPressed: () {
                    if (type == 'Mobile') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddMobileView(type: type),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddStationaryView(type: type),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
