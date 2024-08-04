import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:annapardaan/screens/community/widget/google_gemini_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:mime/mime.dart';
import 'package:toastification/toastification.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  late GoogleGeminiService _geminiService;

  @override
  void initState() {
    super.initState();
    _geminiService =
        GoogleGeminiService(apiKey: 'AIzaSyCH95MQgzZ_BgEZFX5COKLDUi2oQ7SVbWY');
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      if (_postController.text.trim().isEmpty) {
        setState(() {
          _isLoading = true;
        });
        final imageBytes = await _image!.readAsBytes();
        final mimeType = lookupMimeType(_image!.path);
        if (mimeType != null) {
          final generatedCaption = await _geminiService.generateCaption(
              imageBytes, mimeType, 'Generate a caption for this image');
          setState(() {
            _postController.text = generatedCaption ?? 'No caption generated';
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _generateOrRephraseCaption() async {
    if (_image == null) return;

    // setState(() {
    //   _isLoading = true;
    // });

    final imageBytes = await _image!.readAsBytes();
    final mimeType = lookupMimeType(_image!.path);
    if (mimeType != null) {
      final prompt = _postController.text.trim().isEmpty
          ? 'Generate a caption for this image '
          : 'Rephrase: ${_postController.text}';
      final generatedCaption =
          await _geminiService.generateCaption(imageBytes, mimeType, prompt);
      setState(() {
        _postController.text = generatedCaption ?? 'No caption generated';
      });
    }
  }

  Future<void> _createPost() async {
    setState(() {
      _isLoading = true;
    });

    final String postContent = _postController.text.trim();
    if (postContent.isEmpty) {
      
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:    const Text('Post content cannot be empty'));
       
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;

    String? imageUrl;
    if (_image != null) {
      imageUrl = await _uploadImageToFirestore(_image!);
    }

    // Add post data to Firestore
    await _firestore.collection('posts').add({
      'content': postContent,
      'author': user.fullName,
      'timestamp': FieldValue.serverTimestamp(),
      'profileImage': user.profileImage ??
          'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Fallback image URL
      'imageUrl': imageUrl, // Set imageUrl from upload result
      'likes': 0, // Initialize likes to 0
      'comments': 0, // Initialize comments to 0
      'likedBy': [], // Initialize with an empty list
    });

    setState(() {
      _isLoading = false;
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<String?> _uploadImageToFirestore(File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('post_images')
          .child('${DateTime.now().toIso8601String()}.jpg');

      // Upload file
      await ref.putFile(image);

      // Get download URL
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
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
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 19.0),
                    child: CustomButton(
                      text: TText.post,
                      width: 80,
                      onPressed: _createPost,
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100, 
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        user.profileImage ??
                            '', 
                        fit: BoxFit
                            .cover, // Ensures the image covers the rounded corners
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0, width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.group,
                            size: 20, color: Colors.black),
                        label: const Text('Friends',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _postController,
                maxLines: 5,
                cursorColor: TColors.primaryLight,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: TText.inputTextField,
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _image != null
                  ? Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              height: 250,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _image = null;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: _generateOrRephraseCaption,
              child: const Icon(Icons.auto_fix_high),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () => _showImagePicker(context),
              child: const Icon(
                Icons.image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
