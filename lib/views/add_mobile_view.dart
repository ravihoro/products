import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../viewmodel/base_model.dart';
import '../views/home_view.dart';
import 'package:provider/provider.dart';

class AddMobileView extends StatefulWidget {
  final String type;

  AddMobileView({
    this.type,
  });

  @override
  _AddMobileViewState createState() => _AddMobileViewState();
}

class _AddMobileViewState extends State<AddMobileView> {
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
      height: 300,
      child: GridView.builder(
        primary: false,
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
    return Consumer<BaseModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Mobile',
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                await saveImageFileNames();
                model.addProduct(
                  id: _idController.text,
                  name: _nameController.text,
                  type: widget.type,
                  color: _colorController.text,
                  count: int.parse(_countController.text),
                  description: _descriptionController.text,
                  price: double.parse(_priceController.text),
                  images: imageFileNames,
                  ram: int.parse(_ramController.text),
                  storage: int.parse(_storageController.text),
                  processor: _processorController.text,
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeView()));
              }
            },
            child: Container(
              height: 50,
              color: Colors.deepPurple,
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          body: Form(
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
                        if (num.tryParse(value) == null) {
                          return 'Please enter number';
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
                        if (num.tryParse(value) == null) {
                          return 'Please enter number';
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
                      controller: _ramController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter ram";
                        }
                        if (num.tryParse(value) == null) {
                          return 'Please enter number';
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
                      controller: _storageController,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter storage";
                        }
                        if (num.tryParse(value) == null) {
                          return 'Please enter number';
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
                      controller: _processorController,
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
