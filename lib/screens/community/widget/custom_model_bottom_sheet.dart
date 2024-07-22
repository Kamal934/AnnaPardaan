import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatelessWidget {
  const CustomModalBottomSheet({super.key});

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: ListView(
              controller: scrollController,
              children: [
                _buildSheetOption(Icons.photo, "Add Picture"),
                _buildSheetOption(Icons.videocam, "Add a Video"),
                _buildSheetOption(Icons.poll, "Create a Poll"),
                _buildSheetOption(Icons.sentiment_satisfied, "Feeling/Activity"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSheetOption(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(text, style: const TextStyle(color: Colors.black)),
      onTap: () {
        // Handle your onTap action here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showModal(context),
      child: const Text("Show Modal Bottom Sheet"),
    );
  }
}
