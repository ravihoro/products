import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:products/views/home_view.dart';
import '../viewmodel/base_model.dart';
import 'package:provider/provider.dart';
import '../model/mobile.dart';

class EditMobileView extends StatefulWidget {
  final Mobile product;
  final int index;

  EditMobileView({this.product, this.index});

  @override
  _EditMobileViewState createState() => _EditMobileViewState();
}

class _EditMobileViewState extends State<EditMobileView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  TextEditingController _colorController;
  TextEditingController _countController;
  TextEditingController _ramController;
  TextEditingController _storageController;
  TextEditingController _processorController;

  List<String> imageFileNames;
  List<Asset> images;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _colorController = TextEditingController();
    _countController = TextEditingController();
    _ramController = TextEditingController();
    _storageController = TextEditingController();
    _processorController = TextEditingController();
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
          'Add Mobile',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _idController..text = widget.product.id,
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
                      controller: _nameController..text = widget.product.name,
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
                      controller: _descriptionController
                        ..text = widget.product.description,
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
                      controller: _priceController
                        ..text = widget.product.price.toString(),
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
                      controller: _colorController..text = widget.product.color,
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
                      controller: _countController
                        ..text = widget.product.count.toString(),
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
                      height: 5,
                    ),
                    TextFormField(
                      controller: _ramController
                        ..text = widget.product.ram.toString(),
                      validator: (value) {
                        if (value == "") {
                          return "Please enter ram";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'RAM',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _storageController
                        ..text = widget.product.storage.toString(),
                      validator: (value) {
                        if (value == "") {
                          return "Please enter storage";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Storage',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _processorController
                        ..text = widget.product.processor,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter processor";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Processor',
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.deepPurple,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          model.updateProduct(
                            index: widget.index,
                            id: _idController.text,
                            name: _nameController.text,
                            type: widget.product.type,
                            color: _colorController.text,
                            count: int.parse(_countController.text),
                            description: _descriptionController.text,
                            price: double.parse(_priceController.text),
                            images: widget.product.images,
                            ram: int.parse(_ramController.text),
                            storage: int.parse(_storageController.text),
                            processor: _processorController.text,
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()));
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
}
