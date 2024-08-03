import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddingEmailPage extends StatefulWidget {
  const AddingEmailPage({super.key});

  @override
  _AddingEmailPageState createState() => _AddingEmailPageState();
}

class _AddingEmailPageState extends State<AddingEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final List<String> _emails = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    //Email verification
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void _submitEmail() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _emails.add(_controller.text);
        _controller.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email is valid and stored!')),
      );
    }
  }

  void _removeEmail(int index) {
    setState(() {
      _emails.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Email',
          style: GoogleFonts.hammersmithOne(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _emails.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeEmail(index),
                      ),
                      title: Text(
                        _emails[index],
                        style: GoogleFonts.hammersmithOne(),
                      ),
                      tileColor: Colors.grey[200],
                    ),
                  );
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  EmailEntryWidget(
                    controller: _controller,
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitEmail,
                    child: Text(
                      'Submit',
                      style: GoogleFonts.hammersmithOne(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailEntryWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  EmailEntryWidget({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        labelStyle: GoogleFonts.hammersmithOne(),
      ),
      validator: validator,
      style: GoogleFonts.hammersmithOne(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddingEmailPage(),
  ));
}
