import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
//import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../viewmodel/base_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../app/locator.dart';

class AddStationaryView extends StatefulWidget {
  final String type;

  AddStationaryView({
    this.type,
  });

  @override
  _AddStationaryViewState createState() => _AddStationaryViewState();
}

class _AddStationaryViewState extends State<AddStationaryView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController;
  TextEditingController _nameController;
  TextEditingController _typeController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  TextEditingController _colorController;
  TextEditingController _countController;

  List<String> imageFileNames;
  List<Asset> images;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _typeController = TextEditingController();
    //_typeController.text = types[0];
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _colorController = TextEditingController();
    _countController = TextEditingController();

    imageFileNames = [];
    images = [];
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        },
      ),
    );
  }

  Future<void> loadImages() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: false,
        selectedAssets: images,
      );
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Stationary',
        ),
      ),
      body: Consumer<BaseModel>(
        builder: (context, model, child) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _idController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter id";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Id',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter product name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _priceController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter price";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _colorController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter color";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Color',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _countController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter count";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Count',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add Product Images:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IconButton(
                      icon: Icon(Icons.add, size: 30),
                      onPressed: () {
                        loadImages();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    images.length == 0 ? Container() : buildGridView(),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      child: Text('Add'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await saveImageFileNames();
                          model.addProduct(
                            id: _idController.text,
                            name: _nameController.text,
                            type: _typeController.text,
                            color: _colorController.text,
                            count: int.parse(_countController.text),
                            description: _descriptionController.text,
                            price: double.parse(_priceController.text),
                            images: imageFileNames,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future saveImageFileNames() async {
    for (int i = 0; i < images.length; i++) {
      var filePath =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      imageFileNames.add(filePath);
    }
  }
}
