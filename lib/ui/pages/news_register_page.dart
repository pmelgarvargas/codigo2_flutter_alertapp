import 'dart:io';

import 'package:codigo2_alerta/models/news_model.dart';
import 'package:codigo2_alerta/services/api_service.dart';
import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:codigo2_alerta/ui/widgets/button_custom_widget.dart';
import 'package:codigo2_alerta/ui/widgets/general_widget.dart';
import 'package:codigo2_alerta/ui/widgets/textfield_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewsRegisterPage extends StatefulWidget {
  @override
  State<NewsRegisterPage> createState() => _NewsRegisterPageState();
}

class _NewsRegisterPageState extends State<NewsRegisterPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _linkController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _imageFile;

  getImageCamera() async {
    _imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (_imageFile != null) {
      setState(() {});
    }
  }

  getImageGallery() async {
    _imageFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (_imageFile != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kFontPrimaryColor,
        ),
        leading: IconButton(
          onPressed: () {
            //...
            Navigator.pop(context);
          },
          icon: Icon(Icons.share),
        ),
        title: Text(
          "Registrar Noticia",
          style: TextStyle(
            color: kFontPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFieldCustomWidget(
                controller: _titleController,
                label: "Título",
                hintText: "Ingresa un título",
              ),
              spacing14,
              TextFieldCustomWidget(
                controller: _linkController,
                label: "Link",
                hintText: "Ingresa un link",
              ),
              spacing14,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageCamera();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      icon: Icon(Icons.camera),
                      label: Text(
                        "Cámara",
                      ),
                    ),
                  ),
                  spacingWidth12,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageGallery();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      icon: Icon(Icons.image),
                      label: Text(
                        "Galería",
                      ),
                    ),
                  ),
                ],
              ),
              spacing14,
              _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image(
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(_imageFile!.path),
                        ),
                      ),
                    )
                  : SizedBox(),
              spacing20,
              ButtonCustomWidget(
                text: "Registrar noticia",
                onTap: () {
                  ApiService apiService = ApiService();
                  NewsModel model = NewsModel(
                    link: _linkController.text,
                    titulo: _titleController.text,
                    fecha: DateTime.now(),
                    imagen: _imageFile!.path,
                  );
                  apiService.registerNews(model);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
