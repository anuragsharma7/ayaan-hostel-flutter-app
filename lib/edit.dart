import 'package:flutter/material.dart';
import 'package:anayahostelapp/model/note.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _termStartYearController = TextEditingController();
  TextEditingController _termEndYearController = TextEditingController();
  TextEditingController _renewYearController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
      _addressController = TextEditingController(text: widget.note!.address);
      _termStartYearController = TextEditingController(
        text: widget.note!.termStartYear.toString(),
      );
      _termEndYearController = TextEditingController(
        text: widget.note!.termEndYear.toString(),
      );
      _renewYearController = TextEditingController(
        text: widget.note!.renewYear.toString(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 30, 88),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            
            Expanded(
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(125), // 60% of 175
                    child: CircleAvatar(
                      radius: 90, // Adjust size as needed
                      backgroundImage: AssetImage('images/user.png'),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ReusableText('Name', color: Colors.white),
                  CustomTextField(controller: _titleController),

                  ReusableText('Phone Number', color: Colors.white),
                  CustomTextField(controller: _contentController),

                  ReusableText('Address', color: Colors.white),
                  CustomTextField(controller: _addressController),

                  ReusableText('Term start year', color: Colors.white),
                  CustomTextField(controller: _termStartYearController),

                  ReusableText('Term end year', color: Colors.white),
                  CustomTextField(controller: _termEndYearController),

                  ReusableText('Renew year', color: Colors.white),
                  CustomTextField(controller: _renewYearController),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, [
            _titleController.text,
            _contentController.text,
          ]);
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save),
      ),
    );
  }
}

class ReusableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const ReusableText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          decoration: TextDecoration.underline,
          decorationColor: const Color.fromARGB(255, 96, 106, 114),
          decorationThickness: 2,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ), // Reduced size
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something here',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ),
    );
  }
}
