// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageCard extends StatefulWidget {
//   final Function(String) onImagePicked;
//   final List<String> imageUrls;

//   const ImageCard(
//       {super.key, required this.onImagePicked, required this.imageUrls});

//   @override
//   State<ImageCard> createState() => _ImageCardState();
// }

// class _ImageCardState extends State<ImageCard> {
//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       widget.onImagePicked(
//           pickedFile.path); // Call the callback with the picked image path
//     }
//   }

//   void _showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10.0, top: 10),
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                   leading: const Icon(Icons.photo_library),
//                   title: const Text('Photo Library'),
//                   onTap: () {
//                     _pickImage(ImageSource.gallery);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     _pickImage(ImageSource.camera);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         ...widget.imageUrls
//             .map((url) => Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.file(File(url),height: 60,
//                 width: 60,
//                 fit: BoxFit.cover,),
//                   ),
//                 ))
//             ,
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0),
//           child: GestureDetector(
//             child:  Container(
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.grey[200],),
//               height: 60,
//                 width: 60,
//               child: ClipRRect(              
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: const Icon(Icons.add,size: 30, ),
//               ),
//             ),
//             onTap: () => 
//               _showImagePicker(context),

//           ),
//         ),
//       ],
//     );
//   }
// }



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCard extends StatefulWidget {
  final Function(File) onImagePicked;
  final List<File> imageFiles;

  const ImageCard(
      {super.key, required this.onImagePicked, required this.imageFiles});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      widget.onImagePicked(File(pickedFile.path)); // Call the callback with the picked image File
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...widget.imageFiles
            .map((file) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      file,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
            .toList(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              height: 60,
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
            onTap: () => _showImagePicker(context),
          ),
        ),
      ],
    );
  }
}
