import 'package:flutter/material.dart';
import 'package:products/views/edit_mobile_view.dart';
import 'package:products/views/product_detail_view.dart';
import 'package:products/views/type_view.dart';
import '../viewmodel/base_model.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Consumer<BaseModel>(
        builder: (context, model, child) {
          return model.products.length == 0
              ? Center(
                  child: Text('No products. Please add.'),
                )
              : GridView.builder(
                  itemCount: model.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (builder, index) {
                    return InkWell(
                      onTap: () async {
                        //model.currentProduct = model.products[index];
                        //await Future.delayed(Duration(seconds: 1));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailView(
                                product: model.products[index]),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                GestureDetector(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    if (model.products[index].type ==
                                        'Mobile') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => EditMobileView(
                                            index: index,
                                            product: model.products[index],
                                          ),
                                        ),
                                      );
                                    } else {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         EditMobileProduct()));
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File.fromUri(
                                        Uri.parse(
                                            model.products[index].images[0]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              model.products[index].name,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\u{20B9} ${model.products[index].price}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: FileImage(
                        //         File.fromUri(
                        //           Uri.parse(model.products[index].images[0]),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   height: 200,
                        //   width: 200,
                        //   child: Column(
                        //     children: [
                        //       Text(model.products[index].name),
                        //     ],
                        //   ),
                        // ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TypeView()));
        },
      ),
    );
  }
}
