import 'package:flutter/material.dart';
import '../model/product.dart';
import 'dart:io';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailView extends StatelessWidget {
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  final Product product;

  ProductDetailView({
    this.product,
  });

  imageSlider(int index, List<String> imageFiles) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        //double value = 1;
        // if (pageController.position.haveDimensions) {
        //   value = pageController.page - index;
        //   value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        // }
        return Center(
          child: SizedBox(
            child: widget,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(
              File.fromUri(
                Uri.parse(imageFiles[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customImageSlider(BuildContext context, List<String> imageFiles) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: imageFiles.length,
            itemBuilder: (context, index) {
              return imageSlider(index, imageFiles);
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          child: SmoothPageIndicator(
            count: imageFiles.length,
            controller: pageController,
            effect: WormEffect(
              activeDotColor: Theme.of(context).accentColor,
              dotColor: Colors.grey,
              dotWidth: 10.0,
              dotHeight: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.name,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   product.name,
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              SizedBox(height: 15),
              Center(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: customImageSlider(context, product.images),
                ),
              ),
              SizedBox(height: 15),
              Text(
                '\u{20B9} ${product.price}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1.0),
                ),
                child: Text(
                  'Add to Cart',
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                height: 1,
                color: Colors.black12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.favorite),
                        Text(
                          'Add to Favorites',
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        Text(
                          'Share',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                height: 1,
                color: Colors.black12,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TabBar(
                    indicatorColor: Colors.deepPurple,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'Description',
                      ),
                      Tab(
                        text: 'Specs',
                      ),
                    ]),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TabBarView(children: [
                    Text(product.description),
                    _specs(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specs() {
    return Column(
      children: [
        _customRow('Name', product.name),
        _customRow('Type', product.type),
        _customRow('Color', product.color),
        // product.type == 'Mobile'
        //     ? _customRow('RAM', product.name)
        //     : Container(),
        // product.type == 'Mobile'
        //     ? _customRow('Name', product.name)
        //     : Container(),
        // product.type == 'Mobile'
        //     ? _customRow('Name', product.name)
        //     : Container(),
      ],
    );
  }

  Widget _customRow(String key, String value) {
    return Row(
      children: [
        Text('$key: '),
        Text('$value'),
      ],
    );
  }
}
