import 'dart:io';
import 'package:adlicity/features/add_campaign/presentation/cubit/add_campgain_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// typedef ImageFileCallback = void Function(File? imageFile);

// class ImageUploadField extends StatefulWidget {
//   final ImageFileCallback onImageSelected;

//   ImageUploadField({required this.onImageSelected});

//   @override
//   _ImageUploadFieldState createState() => _ImageUploadFieldState();
// }

// class _ImageUploadFieldState extends State<ImageUploadField> {
//   late File? imageFile = null;
//   bool _isUploaded = false;

//   Future<void> _getImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         imageFile = File(image.path);
//         _isUploaded = true;
//       });
//       // Call the callback function to notify the parent widget
//       widget.onImageSelected(imageFile);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (_isUploaded) 
//           Text('Uploaded Successfully', style: TextStyle(color: Colors.blue[300])),
//         ElevatedButton.icon(
//           onPressed: _getImage,
//           icon: Icon(Icons.image),
//           label: Text('Upload Image'),
//         ),
//       ],
//     );
//   }
// }


class ImageUploadField extends StatelessWidget {
  final Function(File?) onImageSelected;

  ImageUploadField({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCampgainCubit, AddCampgainState>(
      builder: (context, state) {
        File? imageFile;
        bool isUploaded = false;

        if (state is ImageSelectedState) {
          imageFile = state.imageFile;
          isUploaded = imageFile != null;
          onImageSelected(imageFile);  // Notify the parent widget
        }

        return Column(
          children: [
            if (isUploaded) 
              Text('Uploaded Successfully', style: TextStyle(color: Colors.blue[300])),
              
            ElevatedButton.icon(
              onPressed: () => context.read<AddCampgainCubit>().selectImage(),
              icon: Icon(Icons.image),
              label: Text('Upload Image'),
            ),
            
          ],
        );
      },
    );
  }
}

